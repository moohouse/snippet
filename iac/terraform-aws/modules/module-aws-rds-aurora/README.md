<!-- BEGIN_TF_DOCS -->

# AWS RDS Aurora module

##### RDS Aurora를 생성하는 모듈입니다.

# Usage
```
module "rds-aurora" {
  source = "../../../modules/module-aws-rds-aurora"

aurora_rds_cluster_create = [
{ index          = "aurora-1"
  engine         = "aurora-mysql"
  engine_version = "8.0.mysql_aurora.3.03.1"

  master_username       = "admin"
  master_password       = "tempPassword"

  sg_index         = ["dev_bastion_pub"]
  aurora_cluster_sbng_index    = "sbng1"
  aurora_cluster_pg_index = "cluster-pg-1"

  skip_final_snapshot = true #false 시 terraform에서 destroy 불가.

  storage_encrypted   = true # DB kms 암호화 하려면 -> true
  deletion_protection = false

  type    = "rds"
  purpose = "mysql1"
}
]

aurora_rds_cluster_instances_create = [
  { index    = "aurora1-instance1"
    number   = "1"
    aurora_instance_pg_index = "pg-1"

    cluster_index              = "aurora-1"
    instance_class             = "db.r5.large"
    auto_minor_version_upgrade = false

    az = "ap-northeast-2a"

    performance_insights_enabled = true

    cluster_purpose = "mysql1"
    type            = "instance"

  },

]

aurora_rds_cluster_pg_create = [
  { index       = "cluster-pg-1"
    family      = "aurora-mysql8.0"
    purpose     = "rds-aurora"
    type        = "cpg"

    parameter = [
     {  name = "innodb_print_all_deadlocks"
        value = 0
      }
    ]
  }
]

aurora_rds_instance_pg_create = [
  { index       = "pg-1"
    family      = "aurora-mysql8.0"
    purpose     = "rds-aurora"
    type        = "pg"

    parameter = [
      { name = "innodb_print_all_deadlocks"
        value = 0
      }, {
        name = "innodb_replication_delay"
        value = 50
      }
    ]
  }
]

aurora_rds_sbng_create = [
  { index            = "sbng1"
    sub_index        = ["sbn2", "sbn1"]
    purpose          = "rds-aurora"
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
| <a name="input_aurora_rds_cluster_create"></a> [aurora\_rds\_cluster\_create](#input\_aurora\_rds\_cluster\_create) | Defined aurora rds cluster(aurora) configuration option values | `any` | n/a | yes |
| <a name="input_aurora_rds_cluster_instances_create"></a> [aurora\_rds\_cluster\_instances\_create](#input\_aurora\_rds\_cluster\_instances\_create) | Defined aurora rds cluster(aurora) instances configuration option values | `any` | n/a | yes |
| <a name="input_aurora_rds_cluster_pg_create"></a> [aurora\_rds\_cluster\_pg\_create](#input\_aurora\_rds\_cluster\_pg\_create) | Defined aurora rds cluster parameter group configuration option values | `any` | `[]` | no |
| <a name="input_aurora_rds_instance_pg_create"></a> [aurora\_rds\_instance\_pg\_create](#input\_aurora\_rds\_instance\_pg\_create) | Defined aurora rds parameter group configuration option values | `any` | `[]` | no |
| <a name="input_aurora_rds_kms_create"></a> [aurora\_rds\_kms\_create](#input\_aurora\_rds\_kms\_create) | Defined DB rds aurora kms key configuration option values | `any` | `[]` | no |
| <a name="input_aurora_rds_sbng_create"></a> [aurora\_rds\_sbng\_create](#input\_aurora\_rds\_sbng\_create) | Defined aurora DB subnetgroup configuration option values | `any` | `[]` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | whole resource take this tags to common | `map(any)` | n/a | yes |
| <a name="input_sg_info"></a> [sg\_info](#input\_sg\_info) | security group information | `any` | `[]` | no |
| <a name="input_subnet_info"></a> [subnet\_info](#input\_subnet\_info) | subnet information | `any` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aurora_rds_kms_info"></a> [aurora\_rds\_kms\_info](#output\_aurora\_rds\_kms\_info) | rds kms key information map type output. |
| <a name="output_rds_cluster_info"></a> [rds\_cluster\_info](#output\_rds\_cluster\_info) | aurora cluster information map type output. |
| <a name="output_rds_cluster_instance_info"></a> [rds\_cluster\_instance\_info](#output\_rds\_cluster\_instance\_info) | aurora cluster instances information map type output. |
<!-- END_TF_DOCS -->