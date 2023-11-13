variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}

variable "subnet_info" {
  description = "subnet information"
  type        = any
  default     = []
}

variable "s3_bucket_info" {
  description = "s3 bucket information"
  type        = any
  default     = []
}

variable "sg_info" {
  description = "security group information"
  type        = any
  default     = []
}

variable "mwaa_create" {
  description = "Defined mwaa configuration option values"
  type        = any
}

variable "mwaa_policy_attach" {
  description = "Defined mwaa iam policy attach configuration option values"
  type        = any
  default     = []
}

variable "mwaa_policy_create" {
  description = "Defined mwaa iam policy configuration option values"
  type        = any
  default     = []
}