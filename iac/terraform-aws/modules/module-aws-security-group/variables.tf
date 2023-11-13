variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}

variable "vpc_info" {
  description = "VPC information"
  type        = map(any)
}

variable "sg_rule_data" {
  description = "security group rule file path"
  type        = any
}

