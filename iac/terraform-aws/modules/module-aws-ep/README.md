<!-- BEGIN_TF_DOCS -->

# AWS VPC endpoint module
##### VPC endpoint를 생성하는 모듈입니다.

# Usage
```
module "endpoint" {
  source = "../../../modules/module-aws-ep"

  ep_interface_create = [
    { index           = "ecr-api"
      vpc_index       = "swlab_dev"
      sub_index       = ["sbn2", "sbn1"]
      svc_name        = "com.amazonaws.ap-northeast-2.ecr.api"
      sg_index        = ["dev_dmz_pri"]
      pri_dns_enabled = true
      purpose         = "ecrapi"
      type            = "vpce"
    }
  ]
  ep_gateway_create = [
    { index     = "s3"
      vpc_index = "swlab_dev"
      rtb_index = ["sbn1", "sbn2"]
      svc_name  = "com.amazonaws.ap-northeast-2.s3"
      purpose   = "s3"
      type      = "vpce"
    }
  ]
  common_tags = {
    Company     = "Mooheadtown"
    Service     = "moo"
    Project     = "moo"
    Environment = "dev"
  }
  vpc_info    = data.terraform_remote_state.remote.outputs.vpc_info
  subnet_info = data.terraform_remote_state.remote.outputs.subnet_info
  rtb_info    = data.terraform_remote_state.remote.outputs.rtb_info
}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | whole resource take this tags to common | `map(any)` | n/a | yes |
| <a name="input_ep_gateway_create"></a> [ep\_gateway\_create](#input\_ep\_gateway\_create) | Defined gateway endpoint configuration option values | `any` | `[]` | no |
| <a name="input_ep_interface_create"></a> [ep\_interface\_create](#input\_ep\_interface\_create) | Defined interface endpoint configuration option values | `any` | `[]` | no |
| <a name="input_rtb_info"></a> [rtb\_info](#input\_rtb\_info) | route table information | `any` | n/a | yes |
| <a name="input_sg_info"></a> [sg\_info](#input\_sg\_info) | security group information | `any` | n/a | yes |
| <a name="input_subnet_info"></a> [subnet\_info](#input\_subnet\_info) | subnet information | `any` | n/a | yes |
| <a name="input_vpc_info"></a> [vpc\_info](#input\_vpc\_info) | vpc information | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ep_gateway_info"></a> [ep\_gateway\_info](#output\_ep\_gateway\_info) | gatway endpoint information map type output |
| <a name="output_ep_interface_info"></a> [ep\_interface\_info](#output\_ep\_interface\_info) | interface endpoint information map type output |
<!-- END_TF_DOCS -->