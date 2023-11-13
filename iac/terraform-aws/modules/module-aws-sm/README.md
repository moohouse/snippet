<!-- BEGIN_TF_DOCS -->

# Secrets Manager
#### Secrets Manager 모듈입니다.

# Usage
```
module "secrets-manager" {
  source = "../../../modules/module-aws-sm"

  sm_create = [
  { index                          = "sm1"
    type                           = "sm"
    kms_index                      = "sm1-kms1" # CMK 사용할 경우 아래 sm_kms_create 변수와 함께 사용. default = aws/secretsmanager
    description                    = "dev/isp Secrets manager"
    recovery_window_in_days        = 0    # 0 or 7~30 가능. 0 : 즉시 삭제 /  default = 30

    secret_string = {
      key1 = "value1"
      key2 = "value2"
    }
  }
]
  ##### CMK #####
  sm_kms_create    = [
  { index                   = "sm1-kms1"
    description             = "sm kms key"
    purpose                 = "sm"
    type                    = "kms"
  }
]
 #####################

  common_tags         = {
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
| <a name="input_sm_create"></a> [sm\_create](#input\_sm\_create) | Defined secrets manager configuration option values | `any` | n/a | yes |
| <a name="input_sm_kms_create"></a> [sm\_kms\_create](#input\_sm\_kms\_create) | Defined secrets manager kms configuration option values | `any` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sm_info"></a> [sm\_info](#output\_sm\_info) | secrets manager information map type output |
| <a name="output_sm_kms_info"></a> [sm\_kms\_info](#output\_sm\_kms\_info) | secrets manager kms key information map type output. |
| <a name="output_sm_ver_info"></a> [sm\_ver\_info](#output\_sm\_ver\_info) | The unique identifier of the version of the secret information map type output |
<!-- END_TF_DOCS -->