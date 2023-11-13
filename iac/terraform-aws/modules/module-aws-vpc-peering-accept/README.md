<!-- BEGIN_TF_DOCS -->
 # AWS vpc peering accept module
 ##### vpc peering accept가 생성되는 모듈입니다.

 # Usage
 ```
 module "vpc-peering-accept" {
   source = "../../../../modules/module-aws-vpc-peering-accept"

 common_tags = {
    Company     = "Mooheadtown"
    Service     = "moo"
    Project     = "moo"
    Environment = "dev"
 }

 vpc_peering_accept_create = [
   {
     index                     = "insilico-dev-isp"
     vpc_peering_connection_id = "pcx-09ac981e0444b5xxx"
     auto_accept               = true
     
   }
 ]

}

 ```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | whole resource take this tags to common | `map(any)` | n/a | yes |
| <a name="input_vpc_peering_accept_create"></a> [vpc\_peering\_accept\_create](#input\_vpc\_peering\_accept\_create) | Defined vpc peering accept configuration option values | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_peering_info"></a> [vpc\_peering\_info](#output\_vpc\_peering\_info) | vpc peering map type output. |
<!-- END_TF_DOCS -->