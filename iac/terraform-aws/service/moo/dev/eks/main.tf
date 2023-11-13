##eks
module "eks-cluster" {
  source = "../../../../modules/module-aws-eks-cluster"

  # tfvars
  common_tags                   = var.common_tags
  eks_cluster_create            = var.eks_cluster_create
  cluster_managed_policy_create = var.cluster_managed_policy_create
  subnet_info                   = data.terraform_remote_state.remote.outputs.subnet_info
  eks_addon_create              = var.eks_addon_create

}

module "eks-node-group" {
  source = "../../../../modules/module-aws-node-group"

  # tfvars
  common_tags              = var.common_tags
  eks_node_group_create    = var.eks_node_group_create
  eks_cluster_info         = module.eks-cluster.eks_cluster_info
  subnet_info              = data.terraform_remote_state.remote.outputs.subnet_info
  sg_info                  = data.terraform_remote_state.remote.outputs.sg_info
  ng_custom_policy_create  = var.ng_custom_policy_create
  ng_managed_policy_create = var.ng_managed_policy_create
}
