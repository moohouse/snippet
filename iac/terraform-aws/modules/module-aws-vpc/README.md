<!-- BEGIN_TF_DOCS -->
 # AWS VPC module
 ##### VPC 와 Internet Gateway를 생성해주는 모듈 입니다.

 # Usage
 ```
  module "vpc" {
   source = "../../../../modules/module-aws-route-vpc"
  common_tags = {
   Company     = "SG"
   Service     = "isp"
   Project     = "wisdom"
   Environment = "dev"
  }

 vpc_create = [
  {
    index                 = "swlab_dev"
    type                 = "vpc"
    cidr_block           = "10.17.0.0/16"
    secondary_cidr_block = null
    instance_tenancy     = "default"
    enable_dns_hostnames = "true"
    enable_dns_support   = "true"
    enable_ipv6          = "false"
    aws_internet_gateway = true
  }
 ]
}
 ```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | whole resource take this tags to common | `map(any)` | n/a | yes |
| <a name="input_vpc_create"></a> [vpc\_create](#input\_vpc\_create) | Defined VPC configuration option values | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_igw_info"></a> [igw\_info](#output\_igw\_info) | igw information map type output. |
| <a name="output_vpc_info"></a> [vpc\_info](#output\_vpc\_info) | vpc information map type output. |
<!-- END_TF_DOCS -->
| Name | Description |
|------|-------------|
| <a name="output_igw_info"></a> [igw\_info](#output\_igw\_info) | igw information map type output. |
| <a name="output_vpc_info"></a> [vpc\_info](#output\_vpc\_info) | vpc information map type output. |
<!-- END_TF_DOCS -->