<!-- BEGIN_TF_DOCS -->

# NAT Gateway & NAT EIP
#### NAT gateway & NAT EIP 생성 모듈입니다.

# Usage
```
module "nat" {
 source = "../../../modules/module-aws-nat"

 nat_create         = [
   { index          = "sbn1-nat"
     type           = "nat"
     sub_index      = "sbn1"
     networkboudary = "pub"
   }
 ]

 subnet_info = data.terraform_remote_state.remote.outputs.subnet_info

 common_tags  = {
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
| <a name="input_nat_create"></a> [nat\_create](#input\_nat\_create) | Defined nat gateway configuration option values | `any` | n/a | yes |
| <a name="input_subnet_info"></a> [subnet\_info](#input\_subnet\_info) | subnet information | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nat_eip_info"></a> [nat\_eip\_info](#output\_nat\_eip\_info) | nat eip information map type output. |
| <a name="output_nat_info"></a> [nat\_info](#output\_nat\_info) | nat information map type output. |
<!-- END_TF_DOCS -->