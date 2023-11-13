data "aws_cloudfront_cache_policy" "managed-cache-policy" {
  for_each = { for cp_map in var.managed_cache_policy : cp_map.name => cp_map }
  name     = each.value.name
}

data "aws_cloudfront_origin_request_policy" "managed-origin-request-policy" {
  for_each = { for corp_map in var.managed_origin_request_policy : corp_map.name => corp_map }
  name     = each.value.name
}

data "aws_cloudfront_response_headers_policy" "managed-response-header-policy" {
  for_each = { for crhp_map in var.managed_response_header_policy : crhp_map.name => crhp_map }
  name     = each.value.name
}

data "aws_acm_certificate" "issued" {
  for_each = { for domain_map in var.acm_info : domain_map.index => domain_map }
  domain   = each.value.domain_name
  statuses = ["ISSUED"]
  provider = aws.alternate
}