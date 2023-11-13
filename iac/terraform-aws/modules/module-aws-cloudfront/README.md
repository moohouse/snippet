<!-- BEGIN_TF_DOCS -->
# AWS Cloudfront module

##### Cloudfront를 생성하는 모듈입니다.

 # Usage
 ```
  module "cloudfront" {
   source = "../../../../modules/module-aws-cloudfront"
   
   cloudfront_create = [
  {
    index        = "cf_1"
    enabled      = true
    comment      = "some comment"
    price_class  = "PriceClass_All"
    aliases      = []
    http_version = "http2"
    acm_index    = "acm_1"

    #origin

    origin = [
      {
        s3_index            = "s3-1"
        origin_id           = "bucket-test"
        origin_path         = ""
        connection_attempts = "3"
        connection_timeout  = "10"

        custom_header = [
            {
                name        = "mzc-test"
                value       = "hskim"
             },
            {
                name        = "mzc-test2"
                value       = "KHS"
            }
        ]

        # origin_shield = [{
        #     enabled = true
        #     origin_shield_region = "us-east-2"
        # }]

        # custom_origin_config = [
        #     {
        #     }
        # ]
      }
    ]
    

    # cache behavior
    target_origin_id       = "bucket-test"
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = false
    default_ttl            = "3600"
    min_ttl                = "0"
    max_ttl                = "86400"

    cache_policy_id            = "cache-policy"
    origin_request_policy_id   = "Managed-CORS-S3Origin"
    response_headers_policy_id = "Managed-CORS-With-Preflight"

    restriction_type = "none"
    locations        = []

    # custom error response
    custom_error_response = {
      error-404 = {
        error_caching_min_ttl = 10 #오류 캐싱 최소 TTL 초 단위
        error_code            = 404
        response_code         = 404
        response_page_path    = "/404.html"
      },
      error-500 = {
        error_caching_min_ttl = 10
        error_code            = 500
        response_code         = 500
        response_page_path    = "/500.html"
      }
    }
  }
]

origin_access_control_create = [
  {
    s3_index = "s3-1"
    name = "oac-test"
    description = "some comment"
    origin_access_control_origin_type = "s3"
    signing_behavior                  = "always"
    signing_protocol                  = "sigv4"
  }
]

managed_cache_policy = [
  {
    name = "Managed-CachingDisabled"
  }
]

managed_origin_request_policy = [
  {
    name = "Managed-CORS-S3Origin"
  }
]

managed_response_header_policy = [
  {
    name = "Managed-CORS-With-Preflight"
  }
]

cache_policy_create = [
  {
    name = "cache-policy"
    comment = "sample policy"
    default_ttl = "3600"
    max_ttl = "43200"
    min_ttl = "0"
    cookie_behavior = "whitelist"
    c_items = ["example"]
    header_behavior = "whitelist"
    h_items = ["example"]
    query_string_behavior = "whitelist"
    q_items = ["example"]
  }
]

origin_request_policy_create = [
  {
    name = "origin-request-policy"
    comment = "sample policy"
    cookie_behavior = "whitelist"
    c_items = ["example"]
    header_behavior = "whitelist"
    h_items = ["example"]
    query_string_behavior = "whitelist"
    q_items = ["example"]
  }
]

response_header_policy_create = [
  {
    name = "response_header_policy"
    custom_headers_config = {
      item1 = {
      header   = "X-Permitted-Cross-Domain-Policies"
      override = true
      value    = "none"
      }
    }

      access_control_allow_credentials       = true
      access_control_allow_headers           = ["Access-Control-Allow-Origin"]
      access_control_allow_methods           = ["GET"]
      access_control_allow_origins           = ["www.naver.com"]
      origin_override                        = true

  }
]

acm_info = [
  {
    index       = "acm_1"
    domain_name = "*.nowevent.click"
  }
]

   common_tags = {
    Company     = "Mooheadtown"
    Service     = "moo"
    Project     = "moo"
    Environment = "dev"
   }

    s3_bucket_info = data.terraform_remote_state.remote.outputs.s3_bucket_info
    
    providers = {
      aws.alternate = aws.virginia
    }
}
 ```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_info"></a> [acm\_info](#input\_acm\_info) | Defined cloudfront configuration option values | `any` | n/a | yes |
| <a name="input_cache_policy_create"></a> [cache\_policy\_create](#input\_cache\_policy\_create) | cloudfront origin access control option values | `any` | `[]` | no |
| <a name="input_cloudfront_create"></a> [cloudfront\_create](#input\_cloudfront\_create) | Defined cloudfront configuration option values | `any` | n/a | yes |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | whole resource take this tags to common | `map(any)` | n/a | yes |
| <a name="input_managed_cache_policy"></a> [managed\_cache\_policy](#input\_managed\_cache\_policy) | Defined cloudfront managed\_cache\_policy configuration option values | `any` | n/a | yes |
| <a name="input_managed_origin_request_policy"></a> [managed\_origin\_request\_policy](#input\_managed\_origin\_request\_policy) | Defined cloudfront managed\_origin\_request\_policy configuration option values | `any` | n/a | yes |
| <a name="input_managed_response_header_policy"></a> [managed\_response\_header\_policy](#input\_managed\_response\_header\_policy) | Defined cloudfront managed\_response\_header\_policy configuration option values | `any` | n/a | yes |
| <a name="input_origin_access_control_create"></a> [origin\_access\_control\_create](#input\_origin\_access\_control\_create) | cloudfront origin access control option values | `any` | `[]` | no |
| <a name="input_origin_request_policy_create"></a> [origin\_request\_policy\_create](#input\_origin\_request\_policy\_create) | cloudfront origin access control option values | `any` | `[]` | no |
| <a name="input_response_header_policy_create"></a> [response\_header\_policy\_create](#input\_response\_header\_policy\_create) | cloudfront origin access control option values | `any` | `[]` | no |
| <a name="input_s3_bucket_info"></a> [s3\_bucket\_info](#input\_s3\_bucket\_info) | s3\_bucket information | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudfront_info"></a> [cloudfront\_info](#output\_cloudfront\_info) | cloudfront information map type output |
<!-- END_TF_DOCS -->