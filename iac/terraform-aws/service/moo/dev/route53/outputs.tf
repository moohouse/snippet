output "zone_info" {
  value       = module.route53.zone_info
  description = "route53 host zone information map type output."
}

output "record_info" {
  value       = module.route53.record_info
  description = "route53 record information map type output."
}