variable "sm_create" {
  description = "Defined secrets manager configuration option values"
  type        = any
}

variable "sm_kms_create" {
  description = "Defined secrets manager kms configuration option values"
  type        = any
  default     = []
}

variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}

# variable "sm_ro_create" {
#   description = "Defined secrets manager rotation configuration option values"
#   type        = any
#   default = []
# }