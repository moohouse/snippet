output "sm_info" {
  value       = aws_secretsmanager_secret.sm
  description = "secrets manager information map type output"
}

output "sm_kms_info" {
  value       = aws_kms_key.sm_kms_key
  description = "secrets manager kms key information map type output."
}


output "sm_ver_info" {
  value       = aws_secretsmanager_secret_version.sm-ver
  description = "The unique identifier of the version of the secret information map type output"
  sensitive   = true
}