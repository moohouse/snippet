<!-- BEGIN_TF_DOCS -->
 # AWS vpc peering request module
 ##### vpc peering request를 생성하는 모듈입니다.

 # Usage
```
 module "vpc-peering-request" {
   source = "../../../../modules/module-aws-vpc-peering-request"

 common_tags = {
    Company     = "Mooheadtown"
    Service     = "moo"
    Project     = "moo"
    Environment = "dev"
 }

 vpc_peering_request_create = [
   {
     index                = "insilico-dev-isp"
     peer_owner_id        = "427493420000" #peering 요청할 상대 account
     peer_vpc_id          = "vpc-9477d2ffxxx" #peering 요청 대상 vpc id
     vpc_index            = "insilico_dev" #요청자 vpc id
     auto_accept          = false
     
   }
 ]
}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | whole resource take this tags to common | `map(any)` | n/a | yes |
| <a name="input_vpc_info"></a> [vpc\_info](#input\_vpc\_info) | vpc information | `map(any)` | n/a | yes |
| <a name="input_vpc_peering_request_create"></a> [vpc\_peering\_request\_create](#input\_vpc\_peering\_request\_create) | Defined vpc\_peering configuration option values | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_peering_info"></a> [vpc\_peering\_info](#output\_vpc\_peering\_info) | vpc\_peering map type output. |
<!-- END_TF_DOCS -->