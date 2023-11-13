# AWS EKS Cluster module

# Usage 
```
module "eks-cluster" {
    source = "../../../../modules/module-aws-eks-cluster"

    eks_cluster_create = [{
        index                   = "eks"
        type                    = "eks-cluster"
        name                    = "eks-cluster"
        cluster_version         = "1.27"
        sub_index               = ["sbn1","sbn2","sbn3","sbn4"]
        enabled_cluster_log_types = ["api","audit"]
        endpoint_public_access  = true
        endpoint_private_access = true 
   }]

    cluster_managed_policy_create = [{
       index = "cluster_managed_policy1"
       policy_name = "AmazonEKSClusterPolicy"
    }]

    eks_addon_create = [{
        index                = "eks_addon1"
        addon_name           = "cni"
        cluster_index        = "eks1"
        resolve_conflicts    = "OVERWRITE"
    }]
    common_tags = {
        Company     = "Mooheadtown"
        Service     = "moo"
        Project     = "moo"
        Environment = "dev"
    }
    subnet_info   = data.terraform_remote_state.remote.outputs.subnet_info
}
```