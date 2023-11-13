output "s3_bucket_info" {
  value       = aws_s3_bucket.s3
  description = "s3 bucket information map type output."
}

output "s3_kms_info" {
  value       = aws_kms_key.s3_kms_key
  description = "s3 kms key information map type output."
}

output "s3_web_info" {
  value       = aws_s3_bucket_website_configuration.web
  description = "s3 web site information map type output."
}