
variable "rds_create" {
  description = "Defined secrets manager kms configuration option values"
  type        = any
  default     = []
}

variable "og_create" {
  description = "Defined secrets manager kms configuration option values"
  type        = any
  default     = []
}

variable "pg_create" {
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


variable "aurora_rds_cluster_create" {
  description = "Defined rds cluster(aurora) configuration option values"
  type        = any
}

variable "aurora_rds_cluster_instances_create" {
  description = "Defined rds cluster(aurora) instances configuration option values"
  type        = any
}

variable "aurora_rds_sbng_create" {
  description = "Defined DB subnetgroup configuration option values"
  type        = any
  default     = []
}

variable "aurora_rds_kms_create" {
  description = "Defined DB rds kms key configuration option values"
  type        = any
  default     = []
}

variable "aurora_rds_cluster_pg_create" {
  description = "Defined rds cluster parameter group configuration option values"
  type        = any
  default     = []
}

variable "aurora_rds_instance_pg_create" {
  description = "Defined rds parameter group configuration option values"
  type        = any
  default     = []
}

variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}