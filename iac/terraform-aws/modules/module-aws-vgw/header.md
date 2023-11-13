# AWS VGW module

# Usage 
```
module "vgw" {
    source = "../../../../modules/module-aws-vgw"

    vgw_create = [{
        index    = "vgw_1"
        type     = "Virtual private gateways"
        vpc_name = moo""
    }]

    common_tags = {
        Company     = "Mooheadtown"
        Service     = "moo"
        Project     = "moo"
        Environment = "dev"
    }

    vpc_info             = data.terraform_remote_state.remote.outputs.vpc_info

}
```