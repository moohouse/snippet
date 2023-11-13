<!-- BEGIN_TF_DOCS -->
# AWS security group module
### security 생성해주는 모듈 입니다.

# Usage
```
 module "security-group" {
  source = "../../../../modules/module-aws-security-group"

  common_tags = {
   Company     = "SG"
   Service     = "isp"
   Project     = "wisdom"
   Environment = "dev"
  }

  sg_rule_data = [
  {
  "description" = "OpenVPN"
  "from_port" = "1194"
  "name" = "dev_bastion_pub"
  "position" = "pub"
  "protocol" = "udp"
  "purpose" = "bastion"
  "source" = "0.0.0.0/0"
  "src_sg" = ""
  "to_port" = "1194"
  "type" = "ingress"
  "vpc" = "insilico_dev"
  }
 ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | whole resource take this tags to common | `map(any)` | n/a | yes |
| <a name="input_sg_rule_data"></a> [sg\_rule\_data](#input\_sg\_rule\_data) | security group rule file path | `any` | n/a | yes |
| <a name="input_vpc_info"></a> [vpc\_info](#input\_vpc\_info) | VPC information | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sg_info"></a> [sg\_info](#output\_sg\_info) | security group information map type output. |
<!-- END_TF_DOCS -->