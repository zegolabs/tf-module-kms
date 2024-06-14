output "kms_key_id" {
  value = aws_kms_key.key.key_id
}

output "kms_key_alias" {
  value = local.alias_name
}