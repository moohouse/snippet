<!-- BEGIN_TF_DOCS -->

# AWS bastion ec2 module
##### bastion ec2를 생성하는 모듈입니다.

# Usage
```
module "ec2-bastion" {
  source = "../../../modules/module-aws-ec2-bastion"

  common_tags = {
    Company     = "Mooheadtown"
    Service     = "moo"
    Project     = "moo"
    Environment = "dev"
  }

  ec2_bastion_create = [{
    index = "ec2-bastion"
    ami = "ami-03db74b70e1da9c56"
    instance_type = "t2.micro"
    sub_index = "sbn1"
    sg_index = ["dev_bastion_pub"]
    volume_size = 8
    volume_type = "gp3"

    network_boundary = "pub"
    purpose = "bastion"
    region_az = "apne2a"
    type = "ec2"
  }]

  sg_info    = data.terraform_remote_state.remote.outputs.vpc_info
  subnet_info = data.terraform_remote_state.remote.outputs.subnet_info

}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | whole resource take this tags to common | `map(any)` | n/a | yes |
| <a name="input_ec2_bastion_create"></a> [ec2\_bastion\_create](#input\_ec2\_bastion\_create) | Defined bastion ec2 configuration option values | `any` | n/a | yes |
| <a name="input_sg_info"></a> [sg\_info](#input\_sg\_info) | security group information | `any` | n/a | yes |
| <a name="input_subnet_info"></a> [subnet\_info](#input\_subnet\_info) | subnet information | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_bastion_info"></a> [ec2\_bastion\_info](#output\_ec2\_bastion\_info) | bastion ec2 information map type output |
<!-- END_TF_DOCS -->