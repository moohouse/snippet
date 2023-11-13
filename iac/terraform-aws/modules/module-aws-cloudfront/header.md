# AWS Cloudfront module

# Usage 
```
module "cloudfront" {
    source = "../../../../modules/module-aws-cloudfront"

    cloudfront_create = [{
        index        = "cf_1"
        enabled      = true
        comment      = "some comment"
        price_class  = "PriceClass_All"
        aliases      = []
        http_version = "http2"
        acm_index    = "acm_1"

        origin = [{
            s3_index            = "s3-1"
            origin_id           = "bucket-test"
            origin_path         = ""
            connection_attempts = "3"
            connection_timeout  = "10"
            custom_header = [{
                name        = "moo-test"
                value       = "moo"
            },
            {
                name        = "moo-test2"
                value       = "moo"
            }]

            # origin_shield = [{
            #     enabled = true
            #     origin_shield_region = "us-east-2"
            # }]
    
            # custom_origin_config = [
            #     {
            #     }
            # ]
        }]

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
    
        custom_error_response = {
            error-404 = {
                error_caching_min_ttl = 10
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
    }]

    origin_access_control_create = [{
        s3_index = "s3-1"
        name = "oac-test"
        description = "some comment"
        origin_access_control_origin_type = "s3"
        signing_behavior                  = "always"
        signing_protocol                  = "sigv4"
    }]

    managed_cache_policy = [{
        name = "Managed-CachingDisabled"
    }]

    managed_origin_request_policy = [{
        name = "Managed-CORS-S3Origin"
    }]

    managed_response_header_policy = [{
        name = "Managed-CORS-With-Preflight"
    }]

    cache_policy_create = [{
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
    }]

    origin_request_policy_create = [{
        name = "origin-request-policy"
        comment = "sample policy"
        cookie_behavior = "whitelist"
        c_items = ["example"]
        header_behavior = "whitelist"
        h_items = ["example"]
        query_string_behavior = "whitelist"
        q_items = ["example"]
    }]

    response_header_policy_create = [{
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
    }]

    acm_info = [{
        index       = "acm_1"
        domain_name = "*.nowevent.click"
    }]

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