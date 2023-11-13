module "route53" {
  source = "../../../../modules/module-aws-route53"

  # tfvars
  hostzone_create = var.hostzone_create
  record_create   = var.record_create
  vpc_info        = data.terraform_remote_state.remote.outputs.vpc_info
  common_tags     = var.common_tags

}

