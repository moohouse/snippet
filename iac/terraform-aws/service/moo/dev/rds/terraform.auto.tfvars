#common Tag
common_tags = {
    Company     = "Mooheadtown"
    Service     = "moo"
    Project     = "moo"
    Environment = "dev"
}

aurora_rds_cluster_pg_create = [
  { index       = "cluster-pg-1"
    family      = "aurora-mysql8.0"
    description = null
    purpose     = "rds-aurora"
    type        = "cpg"
    parameter = [
      { name  = "collation_connection"
        value = "utf8mb4_general_ci"
      },
      { name  = "collation_server"
        value = "utf8mb4_general_ci"
      },
      { name  = "sql_mode"
        value = "ONLY_FULL_GROUP_BY"
      },
      { name  = "slow_query_log"
        value = 1
      },
      { name  = "long_query_time"
        value = 0.1
      },
      { name = "character_set_server"
      value = "utf8mb4" },
      { name  = "binlog_format"
        value = "ROW"
      apply_method = "pending-reboot" },
      { name  = "binlog_checksum"
        value = "NONE"
      apply_method = "pending-reboot" },
      { name  = "binlog_row_image"
        value = "FULL"
      apply_method = "pending-reboot" },
      { apply_method = "pending-reboot"
        name         = "binlog_backup"
      value = 0 },
      { apply_method = "pending-reboot"
        name         = "aurora_enhanced_binlog"
      value = 1 },
      { apply_method = "pending-reboot"
        name         = "binlog_replication_globaldb"
      value = 0 }
    ]
  },
  { index       = "cluster-pg-2"
    family      = "aurora-mysql8.0"
    description = null
    purpose     = "rds-aurora"
    type        = "labide-cpg"
    parameter = [
      { name  = "collation_connection"
        value = "utf8mb4_general_ci"
      },
      { name  = "collation_server"
        value = "utf8mb4_general_ci"
      },
      { name  = "sql_mode"
        value = "ONLY_FULL_GROUP_BY"
      },
      { name  = "slow_query_log"
        value = 1
      },
      { name  = "long_query_time"
        value = 0.1
      },
      { name = "character_set_server"
      value = "utf8mb4" }
    ]
  }
]

aurora_rds_instance_pg_create = [
  { index       = "pg-1"
    family      = "aurora-mysql8.0"
    description = null
    purpose     = "rds-aurora"
    type        = "pg"


  },
  { index       = "pg-2"
    family      = "aurora-mysql8.0"
    description = null
    purpose     = "rds-aurora"
    type        = "labide-pg"


  }
]

aurora_rds_sbng_create = [
  { index            = "sbng1"
    sub_index        = ["sbn7", "sbn8"]
    purpose          = "rds-aurora"
    network_boundary = "pri"
    type             = "sbng"
  },
  { index            = "sbng2"
    sub_index        = ["sbn7", "sbn8"]
    purpose          = "rds-aurora"
    network_boundary = "pri"
    type             = "labide-sbng"
  }
]

aurora_rds_cluster_create = [
  { index          = "aurora-1"
    engine         = "aurora-mysql"
    engine_version = "8.0.mysql_aurora.3.03.1"


    master_username = "admin"
    master_password = "tempPassword!1"


    sg_index                  = ["dev_rds_pri"]
    aurora_cluster_sbng_index = "sbng1"
    aurora_cluster_pg_index   = "cluster-pg-1"

    skip_final_snapshot = true #false 시 terraform에서 destroy 불가.

    storage_encrypted   = true # DB kms 암호화 하려면 -> true
    deletion_protection = false

    type    = "rds"
    purpose = "mysql1"
  },
  { index          = "aurora-2"
    engine         = "aurora-mysql"
    engine_version = "8.0.mysql_aurora.3.03.1"


    master_username = "admin"
    master_password = "sgmysql1234!"


    sg_index                  = ["dev_rds_pri"]
    aurora_cluster_sbng_index = "sbng2"
    aurora_cluster_pg_index   = "cluster-pg-2"

    skip_final_snapshot = true #false 시 terraform에서 destroy 불가.

    storage_encrypted   = true # DB kms 암호화 하려면 -> true
    deletion_protection = false

    type    = "rds"
    purpose = "labide"
  }
]

aurora_rds_cluster_instances_create = [
  { index                    = "aurora1-instance1"
    number                   = "1"
    aurora_instance_pg_index = "pg-1"

    cluster_index              = "aurora-1"
    instance_class             = "db.r5.large"
    auto_minor_version_upgrade = false

    az = "ap-northeast-2a"

    performance_insights_enabled = true


    cluster_purpose = "mysql1"
    type            = "instance"

  },
  { index                    = "aurora2-instance1"
    number                   = "1"
    aurora_instance_pg_index = "pg-2"

    cluster_index              = "aurora-2"
    instance_class             = "db.r6g.large"
    auto_minor_version_upgrade = false

    az = "ap-northeast-2a"

    performance_insights_enabled = true


    cluster_purpose = "labide"
    type            = "instance"

  },

]




# og_create = [
#   {index = "og-2"
#   engine_name = "mysql"
#   major_engine_version = "8.0"

#   option = [
#   {  option_name = "MARIADB_AUDIT_PLUGIN"
#      name = "SERVER_AUDIT_FILE_ROTATE_SIZE"
#      value = 500
#   }
#   ]

#   purpose = "rds-mysql"
#   type = "og"}

# ]

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
    sub_index        = ["sbn7", "sbn8"]
    purpose          = "rds"
    network_boundary = "pri"
    type             = "sbng"
  }
]

rds_create = [
  { index                 = "postgre-1"
    storage               = 400
    storage_type          = "gp3"
    iops                  = 12000
    storage_encryp        = true
    apply_immediately     = true
    max_allocated_storage = 1000

    multi_az       = false
    engine         = "postgres"
    engine_version = "15.2"

    master_secret_manager = false # true or false
    username              = "postgres"
    password              = "tempPassword!1"


    sg_index      = ["dev_rds_pri"]
    db_sbng_index = "sbng1"
    pg_index      = "pg-1"

    skip_final_snapshot = true #false 시 terraform에서 destroy 불가.

    auto_minor_version_upgrade = false
    az                         = "ap-northeast-2a"
    instance_class             = "db.m5d.large"

    deletion_protection = false

    performance_insights_enabled = true

    type    = "rds"
    purpose = "postgre"
  }
]




