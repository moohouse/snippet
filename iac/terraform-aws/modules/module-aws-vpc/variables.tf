# VPC
variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}
variable "vpc_create" {
  description = "Defined VPC configuration option values"
  type        = any
}
