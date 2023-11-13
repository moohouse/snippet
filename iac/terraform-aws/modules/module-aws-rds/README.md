<!-- BEGIN_TF_DOCS -->
# AWS RDS module

##### RDS를 생성하는 모듈입니다.

# Usage
```

module "rds" {
  source = "../../../modules/module-aws-rds"

  # tfvars

  rds_create     =[
{ index          = "postgres-1"

  storage = 400
  storage_type = "io1"
  iops = 3000
  storage_encryp = true
  apply_immediately = true # terraform에서 DB수정시 즉시 변경. false 시 유지관리 기간에 수정진행됨.
  max_allocated_storage = 1000

  instance_class ="db.m5d.xlarge"

  multi_az      = false
  az = "ap-northeast-2a" ## rds instance 생성 될 az
  engine         = "postgres"
  engine_version = "15.2"
  auto_minor_version_upgrade = false

  master_secret_manager = false # true or false
  username       = "postgres"
  password       = "temppassword"

  sg_index         = ["dev_bastion_pub"]
  db_sbng_index    = "sbng1"
  pg_index = "pg-1"
  og_index = "og-1"

  skip_final_snapshot = true #false 시 terraform에서 destroy 불가.

  storage_encrypted   = true # DB kms 암호화 하려면 -> true ; default ; aws/rds
  deletion_protection = false

  performance_insights_enabled = true

  type    = "rds"
  purpose = "postgres"
}
]

 pg_create = [
  { index       = "pg-1"
    family      = "postgres15"
    description = null
    purpose     = "rds-postgres"
    type        = "pg"
  }
]

  sbng_create = [
  { index            = "sbng1"
    sub_index        = ["sbn2", "sbn1"]
    purpose          = "rds"
    network_boundary = "pri"
    type             = "sbng"
  }
]

  common_tags = {
   Company     = "SG"
   Service     = "isp"
   Project     = "wisdom"
   Environment = "dev"
  }

  subnet_info    = data.terraform_remote_state.remote.outputs.subnet_info
  sg_info        = data.terraform_remote_state.remote.outputs.sg_info

}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | whole resource take this tags to common | `map(any)` | n/a | yes |
| <a name="input_og_create"></a> [og\_create](#input\_og\_create) | Defined rds parameter group configuration option values | `any` | `[]` | no |
| <a name="input_pg_create"></a> [pg\_create](#input\_pg\_create) | Defined rds parameter group configuration option values | `any` | `[]` | no |
| <a name="input_rds_create"></a> [rds\_create](#input\_rds\_create) | Defined rds configuration option values | `any` | n/a | yes |
| <a name="input_rds_kms_create"></a> [rds\_kms\_create](#input\_rds\_kms\_create) | Defined DB rds kms key configuration option values | `any` | `[]` | no |
| <a name="input_sbng_create"></a> [sbng\_create](#input\_sbng\_create) | Defined DB subnetgroup configuration option values | `any` | `[]` | no |
| <a name="input_sg_info"></a> [sg\_info](#input\_sg\_info) | security group information | `any` | `[]` | no |
| <a name="input_subnet_info"></a> [subnet\_info](#input\_subnet\_info) | subnet information | `any` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rds_info"></a> [rds\_info](#output\_rds\_info) | rds db information map type output. |
| <a name="output_rds_kms_info"></a> [rds\_kms\_info](#output\_rds\_kms\_info) | rds kms key information map type output. |
<!-- END_TF_DOCS -->