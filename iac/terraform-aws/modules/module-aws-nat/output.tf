output "nat_info" {
  value       = aws_nat_gateway.nat
  description = "nat information map type output."
}

output "nat_eip_info" {
  value       = aws_eip.nat_eip
  description = "nat eip information map type output."
}