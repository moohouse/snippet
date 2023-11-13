variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}

variable "iam_policy_create" {
  description = "AWS IAM policy configuration option values"
  type        = any
  default     = []
}