module "rds" {
  source = "../../../../modules/module-aws-rds"

  # tfvars
  rds_create     = var.rds_create
  pg_create      = var.pg_create
  sbng_create    = var.sbng_create
  og_create      = var.og_create
  rds_kms_create = var.rds_kms_create
  subnet_info    = data.terraform_remote_state.remote.outputs.subnet_info
  sg_info        = data.terraform_remote_state.remote.outputs.sg_info
  common_tags    = var.common_tags
}

module "rds_aurora" {
  source = "../../../../modules/module-aws-rds-aurora"

  # tfvars
  aurora_rds_cluster_create           = var.aurora_rds_cluster_create
  aurora_rds_cluster_instances_create = var.aurora_rds_cluster_instances_create
  aurora_rds_cluster_pg_create        = var.aurora_rds_cluster_pg_create
  aurora_rds_instance_pg_create       = var.aurora_rds_instance_pg_create
  aurora_rds_sbng_create              = var.aurora_rds_sbng_create
  aurora_rds_kms_create               = var.aurora_rds_kms_create
  subnet_info                         = data.terraform_remote_state.remote.outputs.subnet_info
  sg_info                             = data.terraform_remote_state.remote.outputs.sg_info
  common_tags                         = var.common_tags
}