module "backend" {
  source = "../../../../modules/module-aws-backend"

  common_tags          = var.common_tags
  bucket_sse_algorithm = "AES256"
}
