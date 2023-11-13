variable "ec2_bastion_create" {
  description = "Defined secrets manager kms configuration option values"
  type        = any
  default     = []
}

variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}