module "vpc-peering-request" {
  source = "../../../../modules/module-aws-vpc-peering-request"

  # tfvars
  vpc_peering_request_create = var.vpc_peering_request_create
  vpc_info                   = data.terraform_remote_state.remote.outputs.vpc_info

  common_tags = var.common_tags
}

module "vpc-peering-accept" {
  source = "../../../../modules/module-aws-vpc-peering-accept"

  # tfvars
  vpc_peering_accept_create = var.vpc_peering_accept_create

  common_tags = var.common_tags
}


module "vgw" {
  source = "../../../../modules/module-aws-vgw"

  # tfvars
  vgw_create  = var.vgw_create
  common_tags = var.common_tags
  vpc_info    = data.terraform_remote_state.remote.outputs.vpc_info
}