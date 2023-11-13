variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}

variable "aurora_rds_cluster_create" {
  description = "Defined aurora rds cluster(aurora) configuration option values"
  type        = any
}

variable "aurora_rds_cluster_instances_create" {
  description = "Defined aurora rds cluster(aurora) instances configuration option values"
  type        = any
}

variable "aurora_rds_cluster_pg_create" {
  description = "Defined aurora rds cluster parameter group configuration option values"
  type        = any
  default     = []
}

variable "aurora_rds_instance_pg_create" {
  description = "Defined aurora rds parameter group configuration option values"
  type        = any
  default     = []
}

variable "aurora_rds_sbng_create" {
  description = "Defined aurora DB subnetgroup configuration option values"
  type        = any
  default     = []
}

variable "aurora_rds_kms_create" {
  description = "Defined DB rds aurora kms key configuration option values"
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