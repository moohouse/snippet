variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}

variable "s3_create" {
  description = "whole resource take this tags to common"
  type        = any
  default     = []
}

variable "s3_kms_create" {
  description = "whole resource take this tags to common"
  type        = any
  default     = []
}

variable "s3_policy_create" {
  description = "Defined secrets manager kms configuration option values"
  type        = any
  default     = []
}

variable "efs_create" {
  description = "Defined efs configuration option values"
  type        = any
  default     = []
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
  default     = []
}

variable "efs_access_point_create" {
  description = "Defined efs mount target configuration option values"
  type        = any
  default     = []
}

variable "s3_web_create" {
  description = "Defined s3 web site  configuration option values"
  type        = any
  default     = []
}

variable "s3_cors_create" {
  description = "Defined s3 cors configuration values"
  type        = any
  default     = []
}