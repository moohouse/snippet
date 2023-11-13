#common Tag
common_tags = {
    Company     = "Mooheadtown"
    Service     = "moo"
    Project     = "moo"
    Environment = "dev"
}

cloudfront_create = [
  {
    index               = "cf-1"
    enabled             = true
    comment             = "moo-dev Front Web Hosting"
    price_class         = "PriceClass_All"
    aliases             = ["www.moo.is"]
    http_version        = "http2"
    default_root_object = "index.html"
    acm_index           = "acm_1"

    #origin

    origin = [
      {
        s3_index            = ""
        custom_origin       = "frontend.s3-website.ap-northeast-2.amazonaws.com"
        origin_id           = "frontend-s3"
        origin_path         = ""
        connection_attempts = "3"
        connection_timeout  = "10"

        custom_header = [

        ]


        custom_origin_config = [
          {
            http_port              = "80"
            https_port             = "443"
            origin_protocol_policy = "http-only"
            origin_ssl_protocols   = ["TLSv1.2"]
          }
        ]
      }
    ]




    default_cache_behavior = [
      {
        # cache behavior
        target_origin_id       = "frontend-s3"
        viewer_protocol_policy = "redirect-to-https"
        allowed_methods        = ["GET", "HEAD", "OPTIONS"]
        cached_methods         = ["GET", "HEAD"]
        compress               = true

        # default_ttl            = "3600"
        # min_ttl                = "0"
        # max_ttl                = "86400"

        cache_policy_id            = "Managed-CachingOptimized"
        origin_request_policy_id   = "origin-request-policy"
        response_headers_policy_id = "Managed-SimpleCORS"

        function_association = [
          {
            event_type   = "viewer-response"
            function_arn = "arn:aws:cloudfront::629822539430:function/cloud-function-moo-dev"
          }
        ]
      }
    ]

    restriction_type = "none"
    locations        = []

    # custom error response
    custom_error_response = {
      error-404 = {
        error_caching_min_ttl = 10 #오류 캐싱 최소 TTL 초 단위
        error_code            = 404
        response_code         = 404
        response_page_path    = "/404.html"
      }
    }
  },
  {
    index               = "cf-2"
    enabled             = true
    comment             = "moo-dev dspa Web Hosting"
    price_class         = "PriceClass_All"
    aliases             = ["moo.is"]
    http_version        = "http2"
    default_root_object = "index.html"
    acm_index           = "acm_1"

    #origin

    origin = [
      {
        s3_index            = ""
        custom_origin       = "dspa.s3-website.ap-northeast-2.amazonaws.com"
        origin_id           = "moo-s3"
        origin_path         = ""
        connection_attempts = "3"
        connection_timeout  = "10"

        custom_header = [

        ]


        custom_origin_config = [
          {
            http_port              = "80"
            https_port             = "443"
            origin_protocol_policy = "http-only"
            origin_ssl_protocols   = ["TLSv1.2"]
          }
        ]
      }
    ]

    default_cache_behavior = [
      {
        # cache behavior
        target_origin_id       = "moo-s3"
        viewer_protocol_policy = "allow-all"
        allowed_methods        = ["GET", "HEAD"]
        cached_methods         = ["GET", "HEAD"]
        compress               = true

        # default_ttl            = "3600"
        # min_ttl                = "0"
        # max_ttl                = "86400"

        cache_policy_id = "Managed-CachingOptimized"
        # origin_request_policy_id   = "origin-request-policy"
        # response_headers_policy_id = "Managed-SimpleCORS"

        # function_association    = [
        #   {
        #              event_type                 = "viewer-response"
        #              function_arn               = "arn:aws:cloudfront::629822539430:function/cloud-function-moo-dev"
        #   }
        # ]
      }
    ]

    restriction_type = "none"
    locations        = []

    # custom error response
    custom_error_response = {
      error-404 = {
        error_caching_min_ttl = 10 #오류 캐싱 최소 TTL 초 단위
        error_code            = 404
        response_code         = 404
        response_page_path    = "/index.html"
      }
    }
  },
  {
    index        = "cf-3"
    enabled      = true
    comment      = "moo-dev file upload"
    price_class  = "PriceClass_All"
    aliases      = ["file.moo.is"]
    http_version = "http2"
    acm_index    = "acm_1"

    #origin

    origin = [
      {
        s3_index = "s3-3"
        # custom_origin       = "dspa.s3-website.ap-northeast-2.amazonaws.com"
        origin_id           = "file-s3"
        origin_path         = ""
        connection_attempts = "3"
        connection_timeout  = "10"

        custom_header = [

        ]

        # custom_origin_config = [
        #     {
        #       http_port = "80"
        #       https_port = "443"
        #       origin_protocol_policy = "http-only" 
        #       origin_ssl_protocols = ["TLSv1.2"]
        #     }
        # ]
      }
    ]

    default_cache_behavior = [
      {
        # cache behavior
        target_origin_id       = "file-s3"
        viewer_protocol_policy = "allow-all"
        allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
        cached_methods         = ["GET", "HEAD"]
        compress               = true

        # default_ttl            = "3600"
        # min_ttl                = "0"
        # max_ttl                = "86400"

        cache_policy_id            = "Managed-CachingDisabled"
        origin_request_policy_id   = "origin-request-querystring-policy"
        response_headers_policy_id = "response-header-cors-policy"

        function_association = [
          {
            event_type   = "viewer-response"
            function_arn = "arn:aws:cloudfront::629822539430:function/cloud-function-moo-dev"
          }
        ]

      }
    ]

    restriction_type = "none"
    locations        = []

    # custom error response
    custom_error_response = {
    }
  },
  {
    index        = "cf-4"
    enabled      = true
    comment      = "moo-dev Admin API"
    price_class  = "PriceClass_All"
    aliases      = ["admin.moo.is"]
    http_version = "http2"
    acm_index    = "acm_1"

    #origin

    origin = [
      {
        s3_index            = ""
        custom_origin       = "k8s-ispadmin-a61f4c6ac2-186633960.ap-northeast-2.elb.amazonaws.com"
        origin_id           = "k8s-admin-api"
        origin_path         = ""
        connection_attempts = "3"
        connection_timeout  = "10"

        custom_header = [

        ]

        # origin_shield = [{
        #     enabled = true
        #     origin_shield_region = "us-east-2"
        # }]

        custom_origin_config = [
          {
            http_port              = "80"
            https_port             = "443"
            origin_protocol_policy = "match-viewer"
            origin_ssl_protocols   = ["TLSv1.2"]
          }
        ]
      }
    ]




    default_cache_behavior = [
      {
        # cache behavior
        target_origin_id       = "k8s-admin-api"
        viewer_protocol_policy = "allow-all"
        allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
        cached_methods         = ["GET", "HEAD"]
        compress               = true

        default_ttl = "0"
        min_ttl     = "0"
        max_ttl     = "0"

        cache_policy_id            = "Managed-CachingDisabled"
        origin_request_policy_id   = "api-origin-request-policy"
        response_headers_policy_id = "response-header-cors-policy"

        function_association = [
          {
            event_type   = "viewer-response"
            function_arn = "arn:aws:cloudfront::629822539430:function/cloud-function-cors"
          }
        ]
      }
    ]

    restriction_type = "none"
    locations        = []

    # custom error response
    custom_error_response = {
    }
  },
  {
    index        = "cf-5"
    enabled      = true
    comment      = "moo-dev User API"
    price_class  = "PriceClass_All"
    aliases      = ["use.moo.is"]
    http_version = "http2"
    acm_index    = "acm_1"

    #origin

    origin = [
      {
        s3_index            = ""
        custom_origin       = "k8s-ispmain-9b664989b5-1935693499.ap-northeast-2.elb.amazonaws.com"
        origin_id           = "k8s-user-api"
        origin_path         = ""
        connection_attempts = "3"
        connection_timeout  = "10"

        custom_header = [

        ]

        # origin_shield = [{
        #     enabled = true
        #     origin_shield_region = "us-east-2"
        # }]

        custom_origin_config = [
          {
            http_port              = "80"
            https_port             = "443"
            origin_protocol_policy = "match-viewer"
            origin_ssl_protocols   = ["TLSv1.2"]
          }
        ]
      }
    ]




    default_cache_behavior = [
      {
        # cache behavior
        target_origin_id       = "k8s-user-api"
        viewer_protocol_policy = "allow-all"
        allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
        cached_methods         = ["GET", "HEAD"]
        compress               = true

        default_ttl = "0"
        min_ttl     = "0"
        max_ttl     = "0"

        cache_policy_id            = "Managed-CachingDisabled"
        origin_request_policy_id   = "api-origin-request-policy"
        response_headers_policy_id = "response-header-cors-policy"

        function_association = [
          {
            event_type   = "viewer-response"
            function_arn = "arn:aws:cloudfront::629822539430:function/cloud-function-cors"
          }
        ]
      }
    ]

    restriction_type = "none"
    locations        = []

    # custom error response
    custom_error_response = {
    }
  },
  {
    index        = "cf-6"
    enabled      = true
    comment      = "moo-dev public file upload"
    price_class  = "PriceClass_All"
    aliases      = []
    http_version = "http2"
    acm_index    = "acm_1"

    #origin

    origin = [
      {
        s3_index = "s3-8"
        # custom_origin       = "dspa.s3-website.ap-northeast-2.amazonaws.com"
        origin_id           = "pub-file-s3"
        origin_path         = ""
        connection_attempts = "3"
        connection_timeout  = "10"

        custom_header = [

        ]

        # custom_origin_config = [
        #     {
        #       http_port = "80"
        #       https_port = "443"
        #       origin_protocol_policy = "http-only" 
        #       origin_ssl_protocols = ["TLSv1.2"]
        #     }
        # ]
      }
    ]

    default_cache_behavior = [
      {
        # cache behavior
        target_origin_id       = "pub-file-s3"
        viewer_protocol_policy = "allow-all"
        allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
        cached_methods         = ["GET", "HEAD"]
        compress               = true

        # default_ttl            = "3600"
        # min_ttl                = "0"
        # max_ttl                = "86400"

        cache_policy_id            = "Managed-CachingOptimized"
        origin_request_policy_id   = "pub-file-origin-request-policy"
        response_headers_policy_id = "response-header-cors-policy"

        function_association = [
          {
            event_type   = "viewer-response"
            function_arn = "arn:aws:cloudfront::629822539430:function/cloud-function-moo-dev"
          }
        ]

      }
    ]

    restriction_type = "none"
    locations        = []

    # custom error response
    custom_error_response = {
    }
  }
]

managed_cache_policy = [
  {
    name = "Managed-CachingOptimized"
  },
  {
    name = "Managed-CachingDisabled"
  }
]

managed_origin_request_policy = [
  {
    name = "Managed-CORS-CustomOrigin"
  },
  {
    name = "Managed-CORS-S3Origin"
  }
]

managed_response_header_policy = [
  {
    name = "Managed-SimpleCORS"
  }
]

origin_access_control_create = [
  {
    s3_index                          = "s3-4"
    name                              = "oac-s3-frontend"
    description                       = "s3-frontend"
    origin_access_control_origin_type = "s3"
    signing_behavior                  = "always"
    signing_protocol                  = "sigv4"
  },
  {
    s3_index                          = "s3-5"
    name                              = "oac-s3-dspa"
    description                       = "s3-dspa"
    origin_access_control_origin_type = "s3"
    signing_behavior                  = "always"
    signing_protocol                  = "sigv4"
  },
  {
    s3_index                          = "s3-3"
    name                              = "oac-s3-file"
    description                       = "s3-file"
    origin_access_control_origin_type = "s3"
    signing_behavior                  = "never"
    signing_protocol                  = "sigv4"
  },
  {
    s3_index                          = "s3-8"
    name                              = "oac-s3-pub-file"
    description                       = "s3-pub-file"
    origin_access_control_origin_type = "s3"
    signing_behavior                  = "never"
    signing_protocol                  = "sigv4"
  }
]

cache_policy_create = [
]

origin_request_policy_create = [
  {
    name                  = "origin-request-policy"
    header_behavior       = "whitelist"
    h_items               = ["CloudFront-Viewer-Country", "CloudFront-Viewer-City", "CloudFront-Viewer-Address", "CloudFront-Viewer-Time-Zone", "CloudFront-Viewer-Country-Region-Name", "CloudFront-Viewer-Country-Name", "CloudFront-Viewer-Country-Region"]
    cookie_behavior       = "none"
    query_string_behavior = "none"

  },
  {
    name                  = "api-origin-request-policy"
    header_behavior       = "allViewerAndWhitelistCloudFront"
    h_items               = ["CloudFront-Viewer-Country", "CloudFront-Viewer-City", "CloudFront-Viewer-Address", "CloudFront-Viewer-Time-Zone", "CloudFront-Viewer-Country-Region-Name", "CloudFront-Viewer-Country-Name", "CloudFront-Viewer-Country-Region"]
    cookie_behavior       = "all"
    query_string_behavior = "all"
  },
  {
    name                  = "origin-request-querystring-policy"
    header_behavior       = "whitelist"
    h_items               = ["CloudFront-Viewer-Country", "CloudFront-Viewer-City", "CloudFront-Viewer-Address", "CloudFront-Viewer-Time-Zone", "CloudFront-Viewer-Country-Region-Name", "CloudFront-Viewer-Country-Name", "CloudFront-Viewer-Country-Region", "Origin", "Access-Control-Request-Method", "Access-Control-Request-Headers"]
    cookie_behavior       = "none"
    query_string_behavior = "all"

  },
  {
    name                  = "pub-file-origin-request-policy"
    header_behavior       = "whitelist"
    h_items               = ["CloudFront-Viewer-Country", "CloudFront-Viewer-City", "CloudFront-Viewer-Address", "CloudFront-Viewer-Time-Zone", "CloudFront-Viewer-Country-Region-Name", "CloudFront-Viewer-Country-Name", "CloudFront-Viewer-Country-Region", "Origin", "Access-Control-Request-Method", "Access-Control-Request-Headers"]
    cookie_behavior       = "none"
    query_string_behavior = "all"

  }
]

response_header_policy_create = [{

  name                             = "response-header-cors-policy"
  access_control_allow_credentials = true
  access_control_allow_headers     = ["Authorization", "Content-Type"]
  access_control_allow_methods     = ["GET", "HEAD", "PUT", "POST", "PATCH", "DELETE", "OPTIONS"]
  access_control_allow_origins     = ["http://localhost:3000", "http://localhost:3020", "http://localhost:3030"]
  origin_override                  = true
}]

acm_info = [
  {
    index       = "acm_1"
    domain_name = "*.moo.is"
  }
]