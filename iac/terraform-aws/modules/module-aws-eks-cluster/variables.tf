variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}

variable "eks_cluster_create" {
  description = "Defined EKS Cluster configuration option values"
  type        = any
}

variable "subnet_info" {
  description = "vpc id information"
  type        = map(any)
}

variable "cluster_managed_policy_create" {
  description = "Defined EKS cluster IAM managed policy values"
  type        = any
}

variable "eks_addon_create" {
  description = "Defined EKS addon configuration option values"
  type        = any
}


