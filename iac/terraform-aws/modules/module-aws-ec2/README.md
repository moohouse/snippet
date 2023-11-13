<!-- BEGIN_TF_DOCS -->

# AWS ec2 module
##### ec2를 생성하는 모듈입니다.

# Usage
```
module "ec2" {
  source = "../../../modules/module-aws-ec2"

  # tfvars
  ec2_create  = [{
  index = "ec2-1"
  ami = "ami-03db74b70e1da9c56"
  instance_type = "t2.micro"
  sub_index = "sbn1"
  sg_index = ["dev_bastion_pub"]
  volume_size = 8
  volume_type = "gp3"
  network_boundary = "pub"
  purpose = "bastion"
  region_az = "az2a"
  type = "ec2"
  instance_profile_index = "ec2-1"
}]

  iam_create = [{
  index = "ec2-1"
  purpose = "test"
}]

  iam_policy_create = [{
  index = "policy-1"
  purpose = "s3"
  policy = "./iam-policy.json"
}]

  iam_policy_attach  = [{
  index = "attach-1"
  iam_index = "ec2-1"
  custom_policy_index = "policy-1"
},
{
  index = "attach-2"
  iam_index = "ec2-1"
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}
 ]

common_tags = {
  Company     = "SG"
  Service     = "mjtest"
  Project     = "wisdom"
  Environment = "dev"
}

  sg_info    = data.terraform_remote_state.remote.outputs.vpc_info
  subnet_info = data.terraform_remote_state.remote.outputs.subnet_info

}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | whole resource take this tags to common | `map(any)` | n/a | yes |
| <a name="input_ec2_create"></a> [ec2\_create](#input\_ec2\_create) | Defined bastion ec2 configuration option values | `any` | n/a | yes |
| <a name="input_iam_create"></a> [iam\_create](#input\_iam\_create) | Defined iam role configuration option values | `any` | `[]` | no |
| <a name="input_iam_policy_attach"></a> [iam\_policy\_attach](#input\_iam\_policy\_attach) | Defined iam policy role attach configuration option values | `any` | `[]` | no |
| <a name="input_iam_policy_create"></a> [iam\_policy\_create](#input\_iam\_policy\_create) | Defined iam policy configuration option values | `any` | `[]` | no |
| <a name="input_sg_info"></a> [sg\_info](#input\_sg\_info) | security group information | `any` | n/a | yes |
| <a name="input_subnet_info"></a> [subnet\_info](#input\_subnet\_info) | subnet information | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_info"></a> [ec2\_info](#output\_ec2\_info) | ec2 information map type output |
| <a name="output_iam_info"></a> [iam\_info](#output\_iam\_info) | ec2 iam role information map type output |
<!-- END_TF_DOCS -->