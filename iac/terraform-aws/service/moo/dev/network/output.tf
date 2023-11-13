output "vpc_info" {
  value       = module.vpc.vpc_info
  description = "vpc information map type output."
}

output "igw_info" {
  value       = module.vpc.igw_info
  description = "igw information map type output."
}

output "subnet_info" {
  value       = module.subnet.subnet_info
  description = "subnet information map type output."
}

output "nat_info" {
  value       = module.nat.nat_info
  description = "nat information map type output."
}

output "rtb_info" {
  value       = module.route-table.rtb_info
  description = "route-table information map type output"
}

output "sg_info" {
  value       = module.security-group.sg_info
  description = "security group information map type output."
}