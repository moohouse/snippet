output "vpc_peering_info" {
  value       = aws_vpc_peering_connection_accepter.this
  description = "vpc peering map type output."
}