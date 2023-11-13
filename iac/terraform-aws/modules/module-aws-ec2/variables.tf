variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}
variable "ec2_create" {
  description = "Defined bastion ec2 configuration option values"
  type        = any
}

variable "sg_info" {
  description = "security group information"
  type        = any
}


variable "subnet_info" {
  description = "subnet information"
  type        = any
}


variable "iam_create" {
  description = "Defined iam role configuration option values"
  type        = any
  default     = []
}

variable "iam_policy_attach" {
  description = "Defined iam policy role attach configuration option values"
  type        = any
  default     = []
}

variable "iam_policy_create" {
  description = "Defined iam policy configuration option values"
  type        = any
  default     = []
}
