resource "aws_cloudfront_distribution" "this" {
  for_each = { for cf_map in var.cloudfront_create : cf_map.index => cf_map }

  enabled             = each.value.enabled
  comment             = lookup(each.value, "comment", null)
  price_class         = lookup(each.value, "price_class", null)
  aliases             = lookup(each.value, "aliases", null)
  http_version        = lookup(each.value, "http_version", null)
  default_root_object = lookup(each.value, "default_root_object", null)

  dynamic "origin" {
    for_each = try(each.value.origin, {})
    iterator = o
    content {
      domain_name              = length(lookup(o.value, "s3_index", "")) > 0 ? var.s3_bucket_info[o.value.s3_index].bucket_regional_domain_name : o.value.custom_origin
      origin_id                = o.value.origin_id
      origin_path              = try(o.value.origin_path, "")
      connection_attempts      = try(o.value.connection_attempts, 3)
      connection_timeout       = try(o.value.connection_timeout, 10)
      origin_access_control_id = length(lookup(o.value, "s3_index", "")) > 0 ? aws_cloudfront_origin_access_control.this[o.value.s3_index].id : null


      dynamic "custom_header" {
        for_each = try(o.value.custom_header, {})
        iterator = ch
        content {
          name  = try(ch.value.name, null)
          value = try(ch.value.value, null)
        }
      }

      dynamic "origin_shield" {
        for_each = try(o.value.origin_shield, {})
        iterator = sh
        content {
          enabled              = try(sh.value.enabled, false)
          origin_shield_region = try(sh.value.origin_shield_region, null)
        }
      }

      # custom origin 사용시 - origin_access_control_id 대신 사용
      dynamic "custom_origin_config" {
        for_each = try(o.value.custom_origin_config, {})
        iterator = co
        content {
          http_port                = try(co.value.http_port, null)
          https_port               = try(co.value.https_port, null)
          origin_keepalive_timeout = try(co.value.origin_keepalive_timeout, null)
          origin_protocol_policy   = try(co.value.origin_protocol_policy, null)
          origin_read_timeout      = try(co.value.origin_read_timeout, null)
          origin_ssl_protocols     = try(co.value.origin_ssl_protocols, null)

        }
      }
    }
  }

  dynamic "default_cache_behavior" {
    for_each = try(each.value.default_cache_behavior, {})
    iterator = c

    content {
      target_origin_id       = c.value.target_origin_id
      viewer_protocol_policy = c.value.viewer_protocol_policy

      allowed_methods = c.value.allowed_methods
      cached_methods  = c.value.cached_methods
      compress        = lookup(c.value, "compress", false)
      default_ttl     = lookup(c.value, "default_ttl", null)
      min_ttl         = lookup(c.value, "min_ttl", null)
      max_ttl         = lookup(c.value, "max_ttl", null)

      cache_policy_id            = lookup(c.value, "cache_policy_id", null) == null ? null : length(regexall("^Managed", c.value.cache_policy_id)) > 0 ? data.aws_cloudfront_cache_policy.managed-cache-policy[c.value.cache_policy_id].id : aws_cloudfront_cache_policy.this[c.value.cache_policy_id].id
      origin_request_policy_id   = lookup(c.value, "origin_request_policy_id", null) == null ? null : length(regexall("^Managed", c.value.origin_request_policy_id)) > 0 ? data.aws_cloudfront_origin_request_policy.managed-origin-request-policy[c.value.origin_request_policy_id].id : aws_cloudfront_origin_request_policy.this[c.value.origin_request_policy_id].id
      response_headers_policy_id = lookup(c.value, "response_headers_policy_id", null) == null ? null : length(regexall("^Managed", c.value.response_headers_policy_id)) > 0 ? data.aws_cloudfront_response_headers_policy.managed-response-header-policy[c.value.response_headers_policy_id].id : aws_cloudfront_response_headers_policy.this[c.value.response_headers_policy_id].id


      dynamic "function_association" {
        for_each = try(c.value.function_association, {})
        iterator = fa
        content {
          event_type   = try(fa.value.event_type, null)
          function_arn = try(fa.value.function_arn, null)

        }
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = each.value.restriction_type
      locations        = each.value.locations
    }
  }

  viewer_certificate {
    acm_certificate_arn = data.aws_acm_certificate.issued[each.value.acm_index].arn
    # cloudfront_default_certificate = true
    ssl_support_method       = "sni-only" #"vip" or "sni-only" - vip incur extra charges 
    minimum_protocol_version = "TLSv1.2_2021"
  }

  dynamic "custom_error_response" {
    for_each = try(each.value.custom_error_response, {})
    iterator = cer
    content {
      error_code            = cer.value.error_code
      error_caching_min_ttl = try(cer.value.error_caching_min_ttl, null)
      response_code         = try(cer.value.response_code, null)
      response_page_path    = try(cer.value.response_page_path, null)
    }
  }


  tags = merge(
    var.common_tags,
    {
      Type = "cf"
      Name = join("-", [
        var.common_tags.Company,
        var.common_tags.Service,
        var.common_tags.Environment,
        each.value.index
      ])
    }
  )
}



resource "aws_cloudfront_origin_access_control" "this" {
  for_each                          = { for oac_map in var.origin_access_control_create : oac_map.s3_index => oac_map }
  name                              = each.value.name
  description                       = lookup(each.value, "value.description", null)
  origin_access_control_origin_type = each.value.origin_access_control_origin_type
  signing_behavior                  = each.value.signing_behavior
  signing_protocol                  = each.value.signing_protocol
}

resource "aws_cloudfront_cache_policy" "this" {
  for_each    = { for cp_map in var.cache_policy_create : cp_map.name => cp_map }
  name        = each.value.name
  comment     = each.value.comment
  default_ttl = each.value.default_ttl
  max_ttl     = each.value.max_ttl
  min_ttl     = each.value.min_ttl
  parameters_in_cache_key_and_forwarded_to_origin {

    cookies_config {
      cookie_behavior = each.value.cookie_behavior
      cookies {
        items = each.value.c_items
      }
    }
    headers_config {
      header_behavior = each.value.header_behavior
      headers {
        items = each.value.h_items
      }
    }
    query_strings_config {
      query_string_behavior = each.value.query_string_behavior
      query_strings {
        items = each.value.q_items
      }
    }
  }
}


resource "aws_cloudfront_origin_request_policy" "this" {
  for_each = { for orp_map in var.origin_request_policy_create : orp_map.name => orp_map }
  name     = each.value.name
  comment  = lookup(each.value, "comment", null)
  cookies_config {
    cookie_behavior = each.value.cookie_behavior
    # cookies {
    #   items = each.value.c_items
    # }
  }
  headers_config {
    header_behavior = each.value.header_behavior
    headers {
      items = each.value.h_items
    }
  }
  query_strings_config {
    query_string_behavior = each.value.query_string_behavior
    # query_strings {
    #   items = each.value.q_items
    # }
  }
}


resource "aws_cloudfront_response_headers_policy" "this" {
  for_each = { for rhp_map in var.response_header_policy_create : rhp_map.name => rhp_map }
  name     = each.value.name


  dynamic "custom_headers_config" {
    for_each = try(each.value.custom_headers_config, {})
    iterator = chc
    content {
      items {
        header   = chc.value.header
        override = chc.value.override
        value    = chc.value.value
      }
    }
  }

  cors_config {
    access_control_allow_credentials = each.value.access_control_allow_credentials
    access_control_allow_headers {
      items = each.value.access_control_allow_headers
    }
    access_control_allow_methods {
      items = each.value.access_control_allow_methods
    }

    access_control_allow_origins {
      items = each.value.access_control_allow_origins
    }
    origin_override = each.value.origin_override
  }
}