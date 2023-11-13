variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}
variable "ep_interface_create" {
  description = "Defined interface endpoint configuration option values"
  type        = any
  default     = []
}
variable "ep_gateway_create" {
  description = "Defined gateway endpoint configuration option values"
  type        = any
  default     = []
}

variable "sg_info" {
  description = "security group information"
  type        = any
}

variable "vpc_info" {
  description = "vpc information"
  type        = any
}

variable "subnet_info" {
  description = "subnet information"
  type        = any
}

variable "rtb_info" {
  description = "route table information"
  type        = any
}