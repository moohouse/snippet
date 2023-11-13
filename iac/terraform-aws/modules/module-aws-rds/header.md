# AWS RDS module

##### RDS를 생성하는 모듈입니다.

# Usage 
```

module "rds" {
    source = "../../../modules/module-aws-rds"
    
    rds_create     = [{ 
        index          = "postgres-1"
        storage = 400
        storage_type = "io1"
        iops = 3000
        storage_encryp = true
        apply_immediately = true
        max_allocated_storage = 1000
        instance_class ="db.m5d.xlarge"
        multi_az      = false
        az = "ap-northeast-2a"
        engine         = "postgres"
        engine_version = "15.2"
        auto_minor_version_upgrade = false
        master_secret_manager = false 
        username       = "postgres"
        password       = "postgres"
        sg_index         = ["dev_bastion_pub"]
        db_sbng_index    = "sbng1"
        pg_index = "pg-1"
        og_index = "og-1"
        skip_final_snapshot = true 
        storage_encrypted   = false 
        deletion_protection = false
        performance_insights_enabled = true
        type    = "rds"
        purpose = "postgres"
    }]
    
    pg_create = [{ 
        index       = "pg-1"
        family      = "postgres15"
        description = null
        purpose     = "rds-postgres"
        type        = "pg"
    }]
    
    sbng_create = [{ 
        index            = "sbng1"
        sub_index        = ["sbn2", "sbn1"]
        purpose          = "rds"
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