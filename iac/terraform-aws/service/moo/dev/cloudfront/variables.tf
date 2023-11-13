variable "region" {
  default = "ap-northeast-2"
}

variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}

variable "cloudfront_create" {
  description = "Defined cloudfront configuration option values"
  type        = any
  default     = []
}


variable "managed_cache_policy" {
  description = "Defined cloudfront managed_cache_policy configuration option values"
  type        = any
  default     = []
}

variable "managed_origin_request_policy" {
  description = "Defined cloudfront managed_origin_request_policy configuration option values"
  type        = any
  default     = []
}

variable "managed_response_header_policy" {
  description = "Defined cloudfront managed_response_header_policy configuration option values"
  type        = any
  default     = []
}

variable "origin_access_control_create" {
  description = "Defined cloudfront origion access control configuration option values"
  type        = any
  default     = []
}

variable "cache_policy_create" {
  description = "Defined cloudfront cache policy configuration option values"
  type        = any
  default     = []
}

variable "origin_request_policy_create" {
  description = "Defined cloudfront origin request policy configuration option values"
  type        = any
  default     = []
}

variable "response_header_policy_create" {
  description = "Defined cloudfront response header policy configuration option values"
  type        = any
  default     = []
}

variable "acm_info" {
  description = "Defined acm configuration option values"
  type        = any
  default     = []
}