
# AWS RDS Aurora module

# Usage 
```
module "rds-aurora" {
    source = "../../../modules/module-aws-rds-aurora"
    
    aurora_rds_cluster_create = [{ 
        index          = "aurora-1"
        engine         = "aurora-mysql"
        engine_version = "8.0.mysql_aurora.3.03.1"
        master_username       = "admin"
        master_password       = "aurora"
        sg_index         = ["dev_bastion_pub"]
        aurora_cluster_sbng_index    = "sbng1"
        aurora_cluster_pg_index = "cluster-pg-1"
        skip_final_snapshot = true 
        storage_encrypted   = false
        deletion_protection = false 
    
        type    = "rds"
        purpose = "mysql1"
    }]
    
    aurora_rds_cluster_instances_create = [{ 
        index    = "aurora1-instance1"
        number   = "1"
        aurora_instance_pg_index = "pg-1"
        cluster_index              = "aurora-1"
        instance_class             = "db.r5.large"
        auto_minor_version_upgrade = false
        az = "ap-northeast-2a"
        performance_insights_enabled = true
        cluster_purpose = "mysql1"
        type            = "instance"
    }]
    
    aurora_rds_cluster_pg_create = [{ 
        index       = "cluster-pg-1"
        family      = "aurora-mysql8.0"
        purpose     = "rds-aurora"
        type        = "cpg"
        parameter = [{  
            name = "innodb_print_all_deadlocks"
            value = 0
        }]
    }]
    
    aurora_rds_instance_pg_create = [{ 
        index       = "pg-1"
        family      = "aurora-mysql8.0"
        purpose     = "rds-aurora"
        type        = "pg"
        parameter = [{ 
            name = "innodb_print_all_deadlocks"
            value = 0
        }, 
        {
            name = "innodb_replication_delay"
            value = 50
        }]
    }]
    
    aurora_rds_sbng_create = [{ 
        index            = "sbng1"
        sub_index        = ["sbn2", "sbn1"]
        purpose          = "rds-aurora"
        network_boundary = "pri"
        type             = "sbng"
    }]
    
    common_tags = {
        Company     = "Mooheadtown"
        Service     = "moo"
        Project     = "moo"
        Environment = "dev"    
    }
    
    subnet_info    = data.terraform_remote_state.remote.outputs.subnet_info
    sg_info        = data.terraform_remote_state.remote.outputs.sg_info

}

```
