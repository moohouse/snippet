<!-- BEGIN_TF_DOCS -->
# AWS IAM Role module

##### IAM Role을 생성하는 모듈입니다.

 # Usage
 ```
  module "iam-policy" {
   source = "../../../../modules/module-aws-iam-role"
   
  iam_role_create = [
    {
        index  = "iam_role1"
        role_name = "test_role"
        assume_role_policy = "./assume_role_policy.json" #Root 모듈에 assume_role에 해당하는 json 파일 생성하여 경로 명시
    }
  ]

  iam_managed_policy_attatch_create = [
    {
        index   = "managed_policy1"
        managed_policy_name = "CloudFrontReadOnlyAccess"
        iam_role_index = "iam_role1"
    },
    {
        index   = "managed_policy2"
        managed_policy_name = "AmazonEC2FullAccess"  
        iam_role_index = "iam_role1"
    }
  ]

iam_custom_policy_attatch_create = [
   {
        index   = "custom_policy2"
        iam_policy_index = "iam_policy2"  
        iam_role_index = "iam_role1"
   }
]

   common_tags = {
    Company     = "Mooheadtown"
    Service     = "moo"
    Project     = "moo"
    Environment = "dev"
   }
  iam_policy_info = module.iam-policy.iam_policy_info  
}
 ```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | whole resource take this tags to common | `map(any)` | n/a | yes |
| <a name="input_iam_custom_policy_attatch_create"></a> [iam\_custom\_policy\_attatch\_create](#input\_iam\_custom\_policy\_attatch\_create) | IAM custom policy attatch configuration option values | `any` | `[]` | no |
| <a name="input_iam_managed_policy_attatch_create"></a> [iam\_managed\_policy\_attatch\_create](#input\_iam\_managed\_policy\_attatch\_create) | IAM managed policy attatch configuration option values | `any` | `[]` | no |
| <a name="input_iam_policy_info"></a> [iam\_policy\_info](#input\_iam\_policy\_info) | IAM policy information | `any` | `[]` | no |
| <a name="input_iam_role_create"></a> [iam\_role\_create](#input\_iam\_role\_create) | IAM Role configuration option values | `any` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_info"></a> [iam\_role\_info](#output\_iam\_role\_info) | IAM role information map type output. |
<!-- END_TF_DOCS -->