<!-- BEGIN_TF_DOCS -->
 # AWS subnet module
 ##### subnet을 생성해주는 모듈 입니다.

 # Usage
 ```
  module "subnet" {
   source = "../../../../modules/module-aws-subnet"

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
}

 ```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | whole resource take this tags to common | `map(any)` | n/a | yes |
| <a name="input_subnet_create"></a> [subnet\_create](#input\_subnet\_create) | Defined subnet configuration option values | `any` | n/a | yes |
| <a name="input_vpc_info"></a> [vpc\_info](#input\_vpc\_info) | vpc id information | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_info"></a> [subnet\_info](#output\_subnet\_info) | subnet information map type output. |
<!-- END_TF_DOCS -->
| Name | Description |
|------|-------------|
| <a name="output_subnet_info"></a> [subnet\_info](#output\_subnet\_info) | subnet information map type output. |
<!-- END_TF_DOCS -->