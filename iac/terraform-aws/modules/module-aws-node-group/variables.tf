variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}

variable "eks_node_group_create" {
  description = "Defined EKS node group configuration option values"
  type        = any
}

variable "eks_cluster_info" {
  description = "eks cluster information"
  type        = map(any)
}

variable "subnet_info" {
  description = "subnet information"
  type        = map(any)
}

variable "sg_info" {
  description = "security group information"
  type        = map(any)
}

variable "ng_custom_policy_create" {
  description = "Defined node group IAM custom policy values"
  type        = any
}

variable "ng_managed_policy_create" {
  description = "Defined node group IAM managed policy values"
  type        = any
}

