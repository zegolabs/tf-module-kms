resource "aws_kms_key" "key" {
  description = "Key for secrets access group ${var.name}"

  policy = data.aws_iam_policy_document.secret_kms.json

  tags = merge({
    # Ideally this would be the ARN but the KMS key is created before the
    # secret so the ARN is not confirmed.
    for_secret = var.name
  }, local.calculated_tags)
}

resource "aws_kms_alias" "alias" {
  name          = local.alias_name
  target_key_id = aws_kms_key.key.key_id
}

data "aws_iam_policy_document" "secret_kms" {

  statement {
    sid = "Enable root access, but prevent access by IAM policy"

    principals {
      type        = "AWS"
      identifiers = [local.account_root]
    }

    actions = [
      "kms:*"
    ]

    resources = [
      "*"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalType"
      values   = ["Account"]
    }
  }

  statement {
    sid = "Allow admin and secrets TF role to administer the key"

    principals {
      type        = "AWS"
      identifiers = local.admin_roles
    }

    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion",
      "kms:GenerateDataKey",
      "kms:Decrypt",
      "kms:Encrypt"
    ]

    resources = [
      "*"
    ]
  }

  # This generates a policy statement for each namespace/service pair.
  #
  # The naive way to allow the specified namespaces and services would be to
  # pass multiple values for the respective tag and ditch the dynamism.
  # However, multiple values in a condition are treated as a logical `OR` so
  # unintended combinations would be authorised.
  #
  # With dynamism, the logic is `(ns1 AND svc1) OR (ns2 AND svc2)`
  # With naivety, the logic is `(ns1 OR ns2) AND (svc1 OR svc2)`
  # In the latter, ns1/svc2 and ns2/svc1 are both authorised unintentionally.
  dynamic "statement" {
    for_each = var.allowed_readers == null ? [] : var.allowed_readers
    iterator = allowed_reader

    content {
      principals {
        type        = "AWS"
        identifiers = [local.account_root]
      }

      actions = [
        "kms:Decrypt"
      ]

      resources = [
        "*"
      ]

      condition {
        test     = "StringEquals"
        variable = "aws:PrincipalTag/meta.zego.tools/namespace"
        values   = [allowed_reader.value.namespace]
      }

      condition {
        test     = "StringEquals"
        variable = "aws:PrincipalTag/meta.zego.tools/service"
        values   = [allowed_reader.value.service]
      }

      condition {
        test     = "StringEquals"
        variable = "kms:CallerAccount"
        values   = [data.aws_caller_identity.current.account_id]
      }
    }
  }

  # Roles with read-only access can use the key to decrypt
  dynamic "statement" {
    for_each = var.allowed_reader_roles != null ? [1] : []

    content {
      sid = "Allow reader roles to decrypt using the key"

      principals {
        type        = "AWS"
        identifiers = var.allowed_reader_roles
      }

      actions = [
        "kms:Decrypt"
      ]

      resources = [
        "*"
      ]
    }
  }

  # Allow user roles e.g. timed developer access roles to encrypt and decrypt secrets.
  dynamic "statement" {
    for_each = !contains(local.protected_owners, var.owner) && length(local.user_roles) != 0 ? [1] : []

    content {
      sid = "Allow timed access roles to encrypt and decrypt"

      principals {
        type        = "AWS"
        identifiers = local.user_roles
      }

      actions = [
        "kms:Decrypt",
        "kms:Encrypt",
        "kms:GenerateDataKey"
      ]

      resources = [
        "*"
      ]
    }
  }
}
