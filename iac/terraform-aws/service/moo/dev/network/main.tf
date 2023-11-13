##VPC
module "vpc" {
  source = "../../../../modules/module-aws-vpc"

  # tfvars
  vpc_create  = var.vpc_create
  common_tags = var.common_tags
}

#Subnet
module "subnet" {
  source = "../../../../modules/module-aws-subnet"

  # tfvars
  subnet_create = var.subnet_create
  common_tags   = var.common_tags
  vpc_info      = module.vpc.vpc_info
  #vpc_info      = data.terraform_remote_state.remote.outputs.vpc_info
}

module "nat" {
  source = "../../../../modules/module-aws-nat"

  # tfvars
  nat_create  = var.nat_create
  common_tags = var.common_tags
  subnet_info = module.subnet.subnet_info
}

#security-group
module "security-group" {
  source       = "../../../../modules/module-aws-security-group"
  common_tags  = var.common_tags
  vpc_info     = module.vpc.vpc_info
  sg_rule_data = csvdecode(file("./security_group_rules.csv")) #root module경로의 csv파일 decode

}

#route-table
module "route-table" {
  source = "../../../../modules/module-aws-route-table"

  # tfvars
  subnet_create    = var.subnet_create
  common_tags      = var.common_tags
  vpc_info         = module.vpc.vpc_info
  subnet_info      = module.subnet.subnet_info
  igw_info         = module.vpc.igw_info
  nat_info         = module.nat.nat_info
  vpc_peering_info = data.terraform_remote_state.remote.outputs.vpc_peering_info
  vgw_info         = data.terraform_remote_state.remote.outputs.vgw_info

  rt_rule_data = csvdecode(file("./route_rules.csv"))
}

module "endpoint" {
  source = "../../../../modules/module-aws-ep"

  # tfvars
  ep_interface_create = var.ep_interface_create
  ep_gateway_create   = var.ep_gateway_create
  vpc_info            = module.vpc.vpc_info
  subnet_info         = module.subnet.subnet_info
  sg_info             = module.security-group.sg_info
  rtb_info            = module.route-table.rtb_info
  common_tags         = var.common_tags
}