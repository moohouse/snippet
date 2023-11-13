variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}

variable "nat_create" {
  description = "Defined nat gateway configuration option values"
  type        = any
}

variable "subnet_info" {
  description = "subnet information"
  type        = map(any)
}