module "ec2-bastion" {
  source = "../../../../modules/module-aws-ec2-bastion"

  # tfvars
  ec2_bastion_create = var.ec2_bastion_create
  subnet_info        = data.terraform_remote_state.remote.outputs.subnet_info
  sg_info            = data.terraform_remote_state.remote.outputs.sg_info
  common_tags        = var.common_tags
}