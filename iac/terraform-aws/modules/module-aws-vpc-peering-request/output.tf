output "vpc_peering_info" {
  value       = aws_vpc_peering_connection.this
  description = "vpc_peering map type output."
}