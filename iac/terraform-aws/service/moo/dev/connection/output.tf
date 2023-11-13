output "vpc_peering_info" {
  value       = merge(module.vpc-peering-request.vpc_peering_info, module.vpc-peering-accept.vpc_peering_info)
  description = "vpc peering info information map type output."
}

# output "vpc_peering_accept_info" {
#   value       = module.vpc-peering-accept.vpc_peering_info
#   description = "vpc peering info information map type output."
# }

output "vgw_info" {
  value       = module.vgw.vgw_info
  description = "vgw information map type output."
}