output "vpc_info" {
  value       = aws_vpc.this
  description = "vpc information map type output."
}

output "igw_info" {
  value       = aws_internet_gateway.this
  description = "igw information map type output."
}
