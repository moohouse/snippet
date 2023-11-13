output "s3_bucket_info" {
  value       = module.cloudfront.cloudfront_info
  description = "cloudfront information map type output."
}