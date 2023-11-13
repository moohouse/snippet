variable "region" {
  default = "ap-northeast-2"
}

# VPC
variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}

variable "eks_cluster_create" {
  description = "Defined eks_cluster configuration option values"
  type        = any
}

variable "cluster_managed_policy_create" {
  description = "Defined eks_cluster configuration option values"
  type        = any
}

variable "eks_node_group_create" {
  description = "Defined eks_cluster configuration option values"
  type        = any
}

variable "ng_custom_policy_create" {
  description = "Defined eks_cluster configuration option values"
  type        = any
}

variable "ng_managed_policy_create" {
  description = "Defined eks_cluster configuration option values"
  type        = any
}

variable "eks_addon_create" {
  description = "Defined eks_cluster configuration option values"
  type        = any
}
