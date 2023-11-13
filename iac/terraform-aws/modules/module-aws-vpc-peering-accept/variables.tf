variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}


variable "vpc_peering_accept_create" {
  description = "Defined vpc peering accept configuration option values"
  type        = any
}