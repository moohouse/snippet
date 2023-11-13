variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}

variable "cloudfront_create" {
  description = "Defined cloudfront configuration option values"
  type        = any
}

variable "acm_info" {
  description = "Defined cloudfront configuration option values"
  type        = any
}

variable "managed_cache_policy" {
  description = "Defined cloudfront managed_cache_policy configuration option values"
  type        = any
}

variable "managed_origin_request_policy" {
  description = "Defined cloudfront managed_origin_request_policy configuration option values"
  type        = any
}


variable "managed_response_header_policy" {
  description = "Defined cloudfront managed_response_header_policy configuration option values"
  type        = any
}

variable "origin_access_control_create" {
  description = "cloudfront origin access control option values"
  type        = any
  default     = []
}

variable "cache_policy_create" {
  description = "cloudfront origin access control option values"
  type        = any
  default     = []
}

variable "origin_request_policy_create" {
  description = "cloudfront origin access control option values"
  type        = any
  default     = []
}

variable "response_header_policy_create" {
  description = "cloudfront origin access control option values"
  type        = any
  default     = []
}

variable "s3_bucket_info" {
  description = "s3_bucket information"
  type        = any
}