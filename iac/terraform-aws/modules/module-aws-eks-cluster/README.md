<!-- BEGIN_TF_DOCS -->
# AWS EKS Cluster module

##### EKS Cluster를 생성하는 모듈입니다.

 # Usage
 ```
  module "eks-cluster" {
   source = "../../../../modules/module-aws-eks-cluster"
   
   eks_cluster_create = [
   {
    index                   = "insilico_dev_eks"
    type                    = "eks-cluster"
    name                    = "eks-cluster"
    cluster_version         = "1.27"
    sub_index               = ["sbn1","sbn2","sbn3","sbn4"]
    enabled_cluster_log_types = ["api","audit"]
    endpoint_public_access  = true
    endpoint_private_access = true
   }
  ]

  cluster_managed_policy_create = [
  {
    index = "cluster_managed_policy1"
    policy_name = "AmazonEKSClusterPolicy"
  }
]

  eks_addon_create = [
  {
    index                = "eks_addon1"
    addon_name           =  "vpc-cni"
    cluster_index        = "insilico_dev_eks"
    resolve_conflicts    = "OVERWRITE"
  }
  ]
   common_tags = {
    Company     = "Mooheadtown"
    Service     = "moo"
    Project     = "moo"
    Environment = "dev"
   }

   subnet_info   = data.terraform_remote_state.remote.outputs.subnet_info

}
 ```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_managed_policy_create"></a> [cluster\_managed\_policy\_create](#input\_cluster\_managed\_policy\_create) | Defined EKS cluster IAM managed policy values | `any` | n/a | yes |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | whole resource take this tags to common | `map(any)` | n/a | yes |
| <a name="input_eks_addon_create"></a> [eks\_addon\_create](#input\_eks\_addon\_create) | Defined EKS addon configuration option values | `any` | n/a | yes |
| <a name="input_eks_cluster_create"></a> [eks\_cluster\_create](#input\_eks\_cluster\_create) | Defined EKS Cluster configuration option values | `any` | n/a | yes |
| <a name="input_subnet_info"></a> [subnet\_info](#input\_subnet\_info) | vpc id information | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks_cluster_info"></a> [eks\_cluster\_info](#output\_eks\_cluster\_info) | eks cluster information map type output. |
<!-- END_TF_DOCS -->