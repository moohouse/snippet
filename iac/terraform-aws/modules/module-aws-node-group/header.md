# AWS EKS node group module

# Usage 
```
module "eks-node-group" {
    source = "../../../../modules/module-aws-eks-node-group"
    
    eks_node_group_create = [{
        index                = "eks"
        cluster_index        = "eks"
        type                 = "eks-node-group"
        name                 = "eks-ng"
        sub_index            = ["sbn3","sbn4"]
        
        ami_type             = "AL2_x86_64"
        capacity_type        = "ON_DEMAND"
        disk_size            = "20"
        instance_types       = ["t3.medium"]
        sg_index             = null
        
        desired_size         = "1"
        max_size             = "1"
        min_size             = "1"
    
        labels = {
            role = "moo"
        }
    }]
    
    ng_custom_policy_create = [{
        index             = "ng_custom_policy1"
        iam_policy        = "./ClusterAutoScaler_policy.json" 
    }]    
    ng_managed_policy_create = [{
        index = "ng_managed_policy1"
        policy_name = "AmazonEC2ContainerRegistryReadOnly"
    },
    {
        index = "ng_managed_policy2"
        policy_name = "AmazonEKS_CNI_Policy"
    },
    {
        index = "ng_managed_policy3"
        policy_name = "AmazonEKSWorkerNodePolicy"
    }]
    
    common_tags = {
        Company     = "Mooheadtown"
        Service     = "moo"
        Project     = "moo"
        Environment = "dev"
    }
    
    subnet_info             = data.terraform_remote_state.remote.outputs.subnet_info
    sg_info             = data.terraform_remote_state.remote.outputs.sg_info
    eks_cluster_info        = module.eks-cluster.eks_cluster_info

}
```