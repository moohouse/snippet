module "s3" {
  source = "../../../../modules/module-aws-s3"

  # tfvars
  s3_create        = var.s3_create
  s3_kms_create    = var.s3_kms_create
  s3_policy_create = var.s3_policy_create
  s3_web_create    = var.s3_web_create
  s3_cors_create   = var.s3_cors_create
  common_tags      = var.common_tags
}

module "efs" {
  source = "../../../../modules/module-aws-efs"

  # tfvars
  efs_create              = var.efs_create
  efs_mount_target_create = var.efs_mount_target_create
  efs_access_point_create = var.efs_access_point_create
  subnet_info             = data.terraform_remote_state.remote.outputs.subnet_info
  sg_info                 = data.terraform_remote_state.remote.outputs.sg_info
  common_tags             = var.common_tags
}