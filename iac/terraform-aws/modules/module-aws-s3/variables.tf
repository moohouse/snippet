variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}

variable "s3_create" {
  description = "Defined s3 configuration option values"
  type        = any
}

variable "s3_kms_create" {
  description = "Defined s3 kms key configuration option values"
  type        = any
  default     = []
}

variable "s3_policy_create" {
  description = "Defined s3 bucket policy configuration option values"
  type        = any
  default     = []
}

variable "s3_web_create" {
  description = "Defined s3 web site  configuration option values"
  type        = any
  default     = []
}

variable "s3_cors_create" {
  description = "Defined s3 cors  configuration option values"
  type        = any
  default     = []
}