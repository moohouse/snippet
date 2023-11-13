
variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
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