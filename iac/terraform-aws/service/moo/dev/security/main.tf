
module "secrets-manager" {
  source = "../../../../modules/module-aws-sm"

  # tfvars
  sm_create     = var.sm_create
  sm_kms_create = var.sm_kms_create
  common_tags   = var.common_tags
}