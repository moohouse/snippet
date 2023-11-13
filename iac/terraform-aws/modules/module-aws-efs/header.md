
# AWS bastion efs module

# Usage 
```
module "efs" {
    source = "../../../../modules/module-aws-efs"

    common_tags = {
        Company     = "Mooheadtown"
        Service     = "moo"
        Project     = "moo"
        Environment = "dev"
    }

    efs_create = [{ 
        index           = "efs1"
        encrypted       = true
        kms_index       = "efs"
        throughput_mode = "elastic"
        lifecycle_policy = [{ 
            into_IA = "AFTER_30_DAYS"
        }]
        purpose         = "efs"
        type            = "efs"
    }]

    efs_mount_target_create = [{ 
        index     = "efs-mt-1"
        efs_index = "efs1"
        sub_index = "sbn1"
        sg_index  = ["dev_efs_pri"]
    },
    {
        index     = "mt-2"
        efs_index = "efs1"
        sub_index = "sbn2"
        sg_index  = ["dev_efs_pri"]
    }]

    efs_access_point_create = [{ 
        index     = "efs-ap-1"
        efs_index = "efs1"
        posix_user = [{
            gid = 50000
            uid = 50000
        }]
        root_directory = [{ 
            path = "/prometheus"
            creation_info = [{ 
                owner_gid = 50000
                owner_uid = 50000
                permissions = 700 
            }] 
        }]
        name = "prometheus"
    },
    { 
        index     = "efs-ap-2"
        efs_index = "efs1"
        posix_user = [{ 
            gid = 50001
            uid = 50001
            secondary_gids = null 
        }]
        root_directory = [{ 
            path = "/loki"
            creation_info = [{ 
                owner_gid = 50001
                owner_uid = 50001
                permissions = 700 
            }] 
        }]
        name = "prometheus-1-dev"
    }]
    
    vpc_info    = data.terraform_remote_state.remote.outputs.vpc_info
    subnet_info = data.terraform_remote_state.remote.outputs.subnet_info
    
}
```
