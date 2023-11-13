variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}

variable "vgw_create" {
  description = "Defined vgw create configuration option values"
  type        = any
}

variable "vpc_info" {
  description = "vpc information"
  type        = map(any)
}