output "ep_gateway_info" {
  value       = aws_vpc_endpoint.vpc_ep_gateway
  description = "gatway endpoint information map type output"
}

output "ep_interface_info" {
  value       = aws_vpc_endpoint.vpc_ep_interface
  description = "interface endpoint information map type output"
}