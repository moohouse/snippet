<!-- BEGIN_TF_DOCS -->

# AWS route53 module
##### route53를 생성하는 모듈입니다.

# Usage
```
module "route53" {
  source = "../../../modules/module-aws-route53"

  # tfvars

hostzone_create = [
  { index = "hostzone-1"
    name  = "test.com"
  }
]

######## alias zone id ########
alias 배포 시 리소스 별 alias host zone id
# elb_zone_id = "ZWKZPGTI48KDX" (서울)
# CF_zone_id = "Z2FDTNDATAQYW2" (global)
###############################

record_create = [
  { index      = "record1"
    zone_index = "hostzone-1"
    name       = "www"
    type       = "A"
    ttl        = 300 ## alias 아닐 경우 ttl 필수
    records    = ["123.456.78.910"]
  },
  { index      = "record2"
    zone_index = "hostzone-1"
    name       = "terraform.test.com"
    type       = "A"
    alias = [
      { name    = "dualstack.rkwerer-12345678.ap-northeast-2.elb.amazonaws.com"
        zone_id = "ZWKZPGTI48KDX"
      evaluate_target_health = true }
    ]
  }
]
vpc_info            = data.terraform_remote_state.remote.outputs.vpc_info

common_tags = {
 Company     = "SG"
 Service     = "isp"
 Project     = "wisdom"
 Environment = "dev"
}

}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | whole resource take this tags to common | `map(any)` | n/a | yes |
| <a name="input_hostzone_create"></a> [hostzone\_create](#input\_hostzone\_create) | Defined route53 host zone configuration option values | `any` | `[]` | no |
| <a name="input_record_create"></a> [record\_create](#input\_record\_create) | Defined route53 records configuration option values | `any` | `[]` | no |
| <a name="input_vpc_info"></a> [vpc\_info](#input\_vpc\_info) | vpc information | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_record_info"></a> [record\_info](#output\_record\_info) | route53 records information map type output. |
| <a name="output_zone_info"></a> [zone\_info](#output\_zone\_info) | route53 hosted zones information map type output. |
<!-- END_TF_DOCS -->