#common Tag
common_tags = {
    Company     = "Mooheadtown"
    Service     = "moo"
    Project     = "moo"
    Environment = "dev"
}

#EKS
eks_cluster_create = [
  {
    index                     = "moo_dev_eks"
    type                      = "eks-cluster"
    name                      = "eks-cluster"
    cluster_version           = "1.27"
    sub_index                 = ["sbn3", "sbn4", "sbn5", "sbn6"]
    enabled_cluster_log_types = []
    endpoint_public_access    = false
    endpoint_private_access   = true
  }
]

cluster_managed_policy_create = [
  {
    index       = "cluster_managed_policy1"
    policy_name = "AmazonEKSClusterPolicy"
  }
]

eks_addon_create = [
  {
    index             = "eks_addon1"
    addon_name        = "vpc-cni"
    cluster_index     = "moo_dev_eks"
    resolve_conflicts = "OVERWRITE"
  },
  {
    index             = "eks_addon2"
    addon_name        = "kube-proxy"
    cluster_index     = "moo_dev_eks"
    resolve_conflicts = "OVERWRITE"
  },
  {
    index             = "eks_addon3"
    addon_name        = "coredns"
    cluster_index     = "moo_dev_eks"
    resolve_conflicts = "OVERWRITE"
  }
]

eks_node_group_create = [
  {
    index         = "moo_dev_eks_ng"
    cluster_index = "moo_dev_eks"
    type          = "eks-node-group"
    name          = "eks-ng"
    sub_index     = ["sbn5", "sbn6"]

    ami_type       = "AL2_x86_64"
    capacity_type  = "ON_DEMAND"
    disk_size      = "20"
    instance_types = ["t3.xlarge"]
    sg_index       = null

    desired_size = "1"
    max_size     = "1"
    min_size     = "1"

    labels = { role = "moo" }
  },
  {
    index         = "moo_dev_keycloak_ng"
    cluster_index = "moo_dev_eks"
    type          = "eks-node-group"
    name          = "keycloak-ng"
    sub_index     = ["sbn5", "sbn6"]

    ami_type       = "AL2_x86_64"
    capacity_type  = "ON_DEMAND"
    disk_size      = "20"
    instance_types = ["t3.xlarge"]
    sg_index       = null

    desired_size = "1"
    max_size     = "1"
    min_size     = "1"

    labels = { role = "keycloak" }

  },
  {
    index         = "moo_dev_telemetry_ng"
    cluster_index = "moo_dev_eks"
    type          = "eks-node-group"
    name          = "telemetry-ng"
    sub_index     = ["sbn5", "sbn6"]

    ami_type       = "AL2_x86_64"
    capacity_type  = "ON_DEMAND"
    disk_size      = "20"
    instance_types = ["t3.xlarge"]
    sg_index       = null

    desired_size = "2"
    max_size     = "2"
    min_size     = "2"

    labels = { role = "telemetry" }

  },
  {
    index         = "moo_dev_batch_ng"
    cluster_index = "moo_dev_eks"
    type          = "eks-node-group"
    name          = "batch-ng"
    sub_index     = ["sbn5", "sbn6"]

    ami_type       = "AL2_x86_64"
    capacity_type  = "ON_DEMAND"
    disk_size      = "20"
    instance_types = ["t3.xlarge"]
    sg_index       = null

    desired_size = "1"
    max_size     = "1"
    min_size     = "1"

    labels = { role = "batch" }
  }
]

ng_custom_policy_create = [
  {
    index       = "ng_custom_policy1"
    iam_policy  = "./ClusterAutoScaler_policy.json"
    policy_name = "ClusterAutoScaler"
  }
]

ng_managed_policy_create = [
  {
    index       = "ng_managed_policy1"
    policy_name = "AmazonEC2ContainerRegistryReadOnly"
  },
  {
    index       = "ng_managed_policy2"
    policy_name = "AmazonEKS_CNI_Policy"
  },
  {
    index       = "ng_managed_policy3"
    policy_name = "AmazonEKSWorkerNodePolicy"
  },
  {
    index       = "ng_managed_policy4"
    policy_name = "AmazonS3FullAccess"
  },
  {
    index       = "ng_managed_policy5"
    policy_name = "AmazonSESFullAccess"
  },
  {
    index       = "ng_managed_policy6"
    policy_name = "AmazonSSMManagedInstanceCore"
  }
]