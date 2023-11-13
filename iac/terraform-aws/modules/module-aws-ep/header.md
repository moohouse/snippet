
# AWS VPC endpoint module

# Usage 
```
module "endpoint" {
    source = "../../../modules/module-aws-ep"

    ep_interface_create = [{ 
        index           = "ecr-api"
        vpc_index       = "dev"
        sub_index       = ["sbn2", "sbn1"]
        svc_name        = "com.amazonaws.ap-northeast-2.ecr.api"
        sg_index        = ["moo-pri"]
        pri_dns_enabled = true
        purpose         = "ecrapi"
        type            = "vpce"
    }]
    ep_gateway_create = [{ 
        index     = "s3"
        vpc_index = "swlab_dev"
        rtb_index = ["sbn1", "sbn2"]
        svc_name  = "com.amazonaws.ap-northeast-2.s3"
        purpose   = "s3"
        type      = "vpce"
    }]
    common_tags = {
        Company     = "Mooheadtown"
        Service     = "moo"
        Project     = "moo"
        Environment = "dev"
    }
    vpc_info    = data.terraform_remote_state.remote.outputs.vpc_info
    subnet_info = data.terraform_remote_state.remote.outputs.subnet_info
    rtb_info    = data.terraform_remote_state.remote.outputs.rtb_info
}

```
