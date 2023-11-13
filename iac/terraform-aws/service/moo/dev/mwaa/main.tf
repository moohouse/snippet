# module "mwaa" {
#   source = "../../../../modules/module-aws-mwaa"

#   # tfvars
#   mwaa_create        = var.mwaa_create
#   mwaa_policy_create = var.mwaa_policy_create
#   mwaa_policy_attach = var.mwaa_policy_attach
#   subnet_info        = data.terraform_remote_state.remote.outputs.subnet_info
#   sg_info            = data.terraform_remote_state.remote.outputs.sg_info
#   s3_bucket_info     = data.terraform_remote_state.remote_s3.outputs.s3_bucket_info
#   common_tags        = var.common_tags
# }