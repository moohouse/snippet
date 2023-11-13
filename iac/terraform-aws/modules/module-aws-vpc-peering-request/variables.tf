variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}

variable "vpc_peering_request_create" {
  description = "Defined vpc_peering configuration option values"
  type        = any
}

variable "vpc_info" {
  description = "vpc information"
  type        = map(any)
}
