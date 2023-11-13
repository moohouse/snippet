variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}

variable "subnet_create" {
  description = "Defined subnet configuration option values"
  type        = any
}

variable "vpc_info" {
  description = "vpc id information"
  type        = map(any)
}
