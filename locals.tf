locals {

  account_root   = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
  account_tfrole = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.tf_role}"

  syseng_admin_role_arn      = tolist(data.aws_iam_roles.syseng_admin_sso_role.arns)
  syseng_power_user_role_arn = tolist(data.aws_iam_roles.syseng_power_user_sso_role.arns)
  developer_sso_role_arn     = tolist(data.aws_iam_roles.developer_sso_role.arns)

  # Roles for users allowed admin access to secrets
  admin_roles = concat(
    [
      local.account_tfrole
    ],
    local.syseng_admin_role_arn,
    local.syseng_power_user_role_arn
  )

  # Roles for non-admin users allowed to encrypt and decrypt secrets
  user_roles = concat(
    local.developer_sso_role_arn,
  )

  spoof_object = {
    "namespace" = "spoof"
    "service"   = "spoof"
  }

  sole_reader = var.allowed_readers == null ? local.spoof_object : var.allowed_readers[0]

  tags_from_sole_reader = { "meta.zego.tools/namespace" = local.sole_reader.namespace, "meta.zego.tools/service" = local.sole_reader.service }

  tags_for_multi_reader = { "meta.zego.tools/namespace" = "N/A", "meta.zego.tools/service" = "N/A", "meta.zego.tools/shared" = "yes" }

  ns_svc_tags     = var.allowed_readers == null ? {} : (length(var.allowed_readers) == 1 ? local.tags_from_sole_reader : local.tags_for_multi_reader)
  calculated_tags = merge({ "meta.zego.tools/owner" = var.owner, "meta.zego.tools/cost-center" = var.cost_center }, local.ns_svc_tags)

  alias_name = "alias/secret/${var.name}"
}
