variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}
variable "ec2_bastion_create" {
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