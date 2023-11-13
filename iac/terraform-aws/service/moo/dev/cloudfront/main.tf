module "cloudfront" {
  source = "../../../../modules/module-aws-cloudfront"

  # tfvars
  cloudfront_create              = var.cloudfront_create
  common_tags                    = var.common_tags
  s3_bucket_info                 = data.terraform_remote_state.remote.outputs.s3_bucket_info
  managed_cache_policy           = var.managed_cache_policy
  managed_origin_request_policy  = var.managed_origin_request_policy
  managed_response_header_policy = var.managed_response_header_policy
  origin_access_control_create   = var.origin_access_control_create
  cache_policy_create            = var.cache_policy_create
  origin_request_policy_create   = var.origin_request_policy_create
  response_header_policy_create  = var.response_header_policy_create
  acm_info                       = var.acm_info

  providers = {
    aws.alternate = aws.virginia
  }
}