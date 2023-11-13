variable "region" {
  default = "ap-northeast-2"
}

# VPC
variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}

variable "vpc_create" {
  description = "Defined VPC configuration option values"
  type        = any
}

variable "subnet_create" {
  description = "Defined subnet configuration option values"
  type        = any
}

variable "nat_create" {
  description = "Defined nat configuration option values"
  type        = any
}

variable "ep_interface_create" {
  description = "Defined ep_interface configuration option values"
  type        = any
  default     = []
}

variable "ep_gateway_create" {
  description = "Defined ep_gateway configuration option values"
  type        = any
  default     = []
}
