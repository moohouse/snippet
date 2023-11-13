variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}

variable "subnet_create" {
  description = "Defined VPC configuration option values"
  type        = any
}

variable "vpc_info" {
  description = "VPC infomation"
  type        = map(any)
}

variable "subnet_info" {
  description = "subnet infomation"
  type        = map(any)
}

variable "rt_rule_data" {
  description = "route table rule file path"
  type        = any
}

variable "igw_info" {
  description = "Internet Gateway infomation"
  type        = map(any)
  default     = {}
}

variable "nat_info" {
  description = "NAT Gateway infomation"
  type        = map(any)
  default     = {}
}

variable "vpc_peering_info" {
  description = "vpc peering infomation"
  type        = any
  default     = {}
}

variable "vgw_info" {
  description = "virtual private gateway infomation"
  type        = map(any)
  default     = {}
}