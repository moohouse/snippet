output "mwaa_info" {
  value       = aws_mwaa_environment.this
  description = "mwaa information map type output."
}

output "mwaa_iam_info" {
  value       = aws_iam_role.this
  description = "IAM role information map type output."
}
