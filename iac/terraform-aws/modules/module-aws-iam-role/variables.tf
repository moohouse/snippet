variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}

variable "iam_policy_info" {
  description = "IAM policy information"
  type        = any
  default     = []
}

variable "iam_role_create" {
  description = "IAM Role configuration option values"
  type        = any
  default     = []
}

variable "iam_managed_policy_attatch_create" {
  description = "IAM managed policy attatch configuration option values"
  type        = any
  default     = []
}

variable "iam_custom_policy_attatch_create" {
  description = "IAM custom policy attatch configuration option values"
  type        = any
  default     = []
}