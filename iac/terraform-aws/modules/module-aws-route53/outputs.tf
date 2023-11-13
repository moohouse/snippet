output "zone_info" {
  value       = aws_route53_zone.this
  description = "route53 hosted zones information map type output."
}

output "record_info" {
  value       = aws_route53_record.this
  description = "route53 records information map type output."
}