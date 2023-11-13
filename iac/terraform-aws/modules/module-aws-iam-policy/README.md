<!-- BEGIN_TF_DOCS -->
# AWS IAM Policy module

##### IAM Policy를 생성하는 모듈입니다.

 # Usage
 ```
  module "iam-policy" {
   source = "../../../../modules/module-aws-iam-policy"
   
  iam_policy_create = [
    {
        index   = "iam_policy1"
        policy_name = "AWSServiceRoleForAmazonEKS"
        policy  = "./test_custom_policy.json" #Root 모듈에 policy에 해당하는 json 파일 생성하여 경로 명시
    },
    {
        index   = "iam_policy2"
        policy_name = "AWSServiceRoleForAmazonEKS2"
        policy  = "./test_custom_policy.json" #Root 모듈에 policy에 해당하는 json 파일 생성하여 경로 명시
    }
  ]

   common_tags = {
    Company     = "Mooheadtown"
    Service     = "moo"
    Project     = "moo"
    Environment = "dev"
   }

}
 ```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | whole resource take this tags to common | `map(any)` | n/a | yes |
| <a name="input_iam_policy_create"></a> [iam\_policy\_create](#input\_iam\_policy\_create) | AWS IAM policy configuration option values | `any` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_policy_info"></a> [iam\_policy\_info](#output\_iam\_policy\_info) | IAM policy information map type output. |
<!-- END_TF_DOCS -->