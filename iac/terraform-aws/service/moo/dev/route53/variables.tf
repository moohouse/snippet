variable "hostzone_create" {
  description = "Defined route53 host zone configuration option values"
  type        = any
  default     = []
}

variable "record_create" {
  description = "Defined route53 records configuration option values"
  type        = any
  default     = []
}

variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}
