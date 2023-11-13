<!-- BEGIN_TF_DOCS -->
# AWS MWAA module

##### MWAA를 생성하는 모듈입니다.

 # Usage
 ```
module "mwaa" {
  source = "../../../modules/module-aws-mwaa"

  # tfvars
  mwaa_create  = [
  { index = "mwaa-1"
    dags_path = "dags/"
    s3_index = "s3-1"
    requirements_s3_path = "requirements.txt"
    sg_index = ["dev_mwaa_pri"]
    sub_index = ["sbn3","sbn4"]
    webs_access_mode = "PRIVATE_ONLY"
    task_logs = [
      { task_logs = true
        task_logs_level = "INFO"
      }
    ]
    worker_logs = [
      { worker_logs = true
        worker_logs_level = "INFO"
      }
    ]
    airflow_version = "2.5.1"
}]

  mwaa_policy_create = [
  { index = "policy-1"
    policy = "./mwaa.json"
  }]
  mwaa_policy_attach = [
  {index = "attach-1"
   custom_policy_index = "policy-1"
},
  {index = "attach-2"
   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}
]

  common_tags = {
    Company     = "Mooheadtown"
    Service     = "moo"
    Project     = "moo"
    Environment = "dev"
   }

  subnet_info = data.terraform_remote_state.remote.outputs.subnet_info
  sg_info = data.terraform_remote_state.remote.outputs.sg_info
  s3_bucket_info = data.terraform_remote_state.remote_s3.outputs.s3_bucket_info

}
 ```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | whole resource take this tags to common | `map(any)` | n/a | yes |
| <a name="input_mwaa_create"></a> [mwaa\_create](#input\_mwaa\_create) | Defined mwaa configuration option values | `any` | n/a | yes |
| <a name="input_mwaa_policy_attach"></a> [mwaa\_policy\_attach](#input\_mwaa\_policy\_attach) | Defined mwaa iam policy attach configuration option values | `any` | `[]` | no |
| <a name="input_mwaa_policy_create"></a> [mwaa\_policy\_create](#input\_mwaa\_policy\_create) | Defined mwaa iam policy configuration option values | `any` | `[]` | no |
| <a name="input_s3_bucket_info"></a> [s3\_bucket\_info](#input\_s3\_bucket\_info) | s3 bucket information | `any` | `[]` | no |
| <a name="input_sg_info"></a> [sg\_info](#input\_sg\_info) | security group information | `any` | `[]` | no |
| <a name="input_subnet_info"></a> [subnet\_info](#input\_subnet\_info) | subnet information | `any` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_mwaa_iam_info"></a> [mwaa\_iam\_info](#output\_mwaa\_iam\_info) | IAM role information map type output. |
| <a name="output_mwaa_info"></a> [mwaa\_info](#output\_mwaa\_info) | mwaa information map type output. |
<!-- END_TF_DOCS -->