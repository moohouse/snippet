output "rds_info" {
  value       = aws_db_instance.rds_db_instance
  description = "rds db information map type output."
}


output "rds_kms_info" {
  value       = aws_kms_key.rds_kms_key
  description = "rds kms key information map type output."
}