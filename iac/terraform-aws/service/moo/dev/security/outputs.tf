output "sm_info" {
  value       = module.secrets-manager.sm_info
  description = "secrets manager information map type output"
}

output "sm_kms_info" {
  value       = module.secrets-manager.sm_kms_info
  description = "secrets manager kms key information map type output."
}
