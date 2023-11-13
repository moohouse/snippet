output "s3_bucket_info" {
  value       = module.s3.s3_bucket_info
  description = "s3 bucket information map type output."
}

output "s3_kms_info" {
  value       = module.s3.s3_kms_info
  description = "s3 kms key information map type output."
}

output "efs_info" {
  value       = module.efs.efs_info
  description = "efs  information map type output"
}