<!-- BEGIN_TF_DOCS -->
 # AWS route-table module
 ##### route-table을 생성해주는 모듈 입니다.

 # Usage
 ```
  module "aws_route-table" {
   source = "../../../../modules/module-aws-route-table"

  common_tags = {
   Company     = "SG"
   Service     = "isp"
   Project     = "wisdom"
   Environment = "dev"
  }

  subnet_create = [
  {
    index                    = "sbn1"
    vpc_index                = "moo_dev"
    purpose                 = "bastion"
    type                    = "sbn"
    position                = "public"
    availability_zone       = "ap-northeast-2a"
    cidr_block              = "10.17.0.0/24"
    map_public_ip_on_launch = "true"
  }
 ]

  rt_rule_data = [
  {
    "description" = ""
    "dst_cidr" = "0.0.0.0/0"
    "igw" = "insilico_dev"
    "nat" = ""
    "pcx" = ""
    "pl" = ""
    "sub_index" = "sbn1"
    "tgw" = ""
    "vpc" = "insilico_dev"
    "vpce" = ""
  }
 ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | whole resource take this tags to common | `map(any)` | n/a | yes |
| <a name="input_igw_info"></a> [igw\_info](#input\_igw\_info) | Internet Gateway infomation | `map(any)` | `{}` | no |
| <a name="input_nat_info"></a> [nat\_info](#input\_nat\_info) | NAT Gateway infomation | `map(any)` | `{}` | no |
| <a name="input_rt_rule_data"></a> [rt\_rule\_data](#input\_rt\_rule\_data) | route table rule file path | `any` | n/a | yes |
| <a name="input_subnet_create"></a> [subnet\_create](#input\_subnet\_create) | Defined VPC configuration option values | `any` | n/a | yes |
| <a name="input_subnet_info"></a> [subnet\_info](#input\_subnet\_info) | subnet infomation | `map(any)` | n/a | yes |
| <a name="input_vgw_info"></a> [vgw\_info](#input\_vgw\_info) | virtual private gateway infomation | `map(any)` | `{}` | no |
| <a name="input_vpc_info"></a> [vpc\_info](#input\_vpc\_info) | VPC infomation | `map(any)` | n/a | yes |
| <a name="input_vpc_peering_info"></a> [vpc\_peering\_info](#input\_vpc\_peering\_info) | vpc peering infomation | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rtb_info"></a> [rtb\_info](#output\_rtb\_info) | route-table information map type output |
<!-- END_TF_DOCS -->
No outputs.
<!-- END_TF_DOCS -->