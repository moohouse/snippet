<!-- BEGIN_TF_DOCS -->
# AWS EKS node group module

##### EKS node group을 생성하는 모듈입니다.

 # Usage
 ```
  module "eks-node-group" {
   source = "../../../../modules/module-aws-eks-node-group"
   
   eks_node_group_create = [
   {
    index                = "insilico_dev_eks_ng"
    cluster_index        = "insilico_dev_eks"
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

    labels = {role = "isp"}
   }
  ]

  ng_custom_policy_create = [
  {
    index             = "ng_custom_policy1"
    iam_policy        = "./ClusterAutoScaler_policy.json"  #루트모듈 내 policy(json파일) 사용
  }
]

  ng_managed_policy_create = [
  {
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
  }
]

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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | whole resource take this tags to common | `map(any)` | n/a | yes |
| <a name="input_eks_cluster_info"></a> [eks\_cluster\_info](#input\_eks\_cluster\_info) | eks cluster information | `map(any)` | n/a | yes |
| <a name="input_eks_node_group_create"></a> [eks\_node\_group\_create](#input\_eks\_node\_group\_create) | Defined EKS node group configuration option values | `any` | n/a | yes |
| <a name="input_ng_custom_policy_create"></a> [ng\_custom\_policy\_create](#input\_ng\_custom\_policy\_create) | Defined node group IAM custom policy values | `any` | n/a | yes |
| <a name="input_ng_managed_policy_create"></a> [ng\_managed\_policy\_create](#input\_ng\_managed\_policy\_create) | Defined node group IAM managed policy values | `any` | n/a | yes |
| <a name="input_sg_info"></a> [sg\_info](#input\_sg\_info) | security group information | `map(any)` | n/a | yes |
| <a name="input_subnet_info"></a> [subnet\_info](#input\_subnet\_info) | subnet information | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks_node_group_info"></a> [eks\_node\_group\_info](#output\_eks\_node\_group\_info) | eks node group information map type output. |
<!-- END_TF_DOCS -->