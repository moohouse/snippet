<!-- BEGIN_TF_DOCS -->
# AWS VGW module

##### VPN에서 사용될 VGW 을 생성하는 모듈입니다.

 # Usage
 ```
  module "vgw" {
   source = "../../../../modules/module-aws-vgw"
   
   vgw_create = [
   {
    index    = "vgw_1"
    type     = "Virtual private gateways"
    vpc_name = "insilico_dev"
   }
  ]

   common_tags = {
    Company     = "Mooheadtown"
    Service     = "moo"
    Project     = "moo"
    Environment = "dev"
   }

   vpc_info             = data.terraform_remote_state.remote.outputs.vpc_info

}
 ```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | whole resource take this tags to common | `map(any)` | n/a | yes |
| <a name="input_vgw_create"></a> [vgw\_create](#input\_vgw\_create) | Defined vgw create configuration option values | `any` | n/a | yes |
| <a name="input_vpc_info"></a> [vpc\_info](#input\_vpc\_info) | vpc information | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vgw_info"></a> [vgw\_info](#output\_vgw\_info) | vgw information map type output. |
<!-- END_TF_DOCS -->