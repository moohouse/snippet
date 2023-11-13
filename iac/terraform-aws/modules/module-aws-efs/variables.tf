variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
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

variable "efs_create" {
  description = "Defined efs configuration option values"
  type        = any
}

variable "efs_policy_create" {
  description = "Defined efs policy configuration option values"
  type        = any
  default     = []
}

variable "efs_backup_policy_create" {
  description = "Defined efs backup policy configuration option values"
  type        = any
  default     = []
}

variable "efs_kms_create" {
  description = "Defined efs kms key configuration option values"
  type        = any
  default     = []
}

variable "efs_mount_target_create" {
  description = "Defined efs mount target configuration option values"
  type        = any
}

variable "efs_access_point_create" {
  description = "Defined efs mount target configuration option values"
  type        = any
}
