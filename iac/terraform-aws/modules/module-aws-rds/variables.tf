variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}


variable "rds_create" {
  description = "Defined rds configuration option values"
  type        = any
}

variable "pg_create" {
  description = "Defined rds parameter group configuration option values"
  type        = any
  default     = []
}

variable "og_create" {
  description = "Defined rds parameter group configuration option values"
  type        = any
  default     = []
}

variable "sbng_create" {
  description = "Defined DB subnetgroup configuration option values"
  type        = any
  default     = []
}

variable "rds_kms_create" {
  description = "Defined DB rds kms key configuration option values"
  type        = any
  default     = []
}

variable "subnet_info" {
  description = "subnet information"
  type        = any
  default     = []
}

variable "sg_info" {
  description = "security group information"
  type        = any
  default     = []
}

