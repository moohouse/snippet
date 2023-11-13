# AWS vpc peering accept module

# Usage 
```
module "vpc-peering-accept" {
    source = "../../../../modules/module-aws-vpc-peering-accept"
    
    common_tags = {
        Company     = "Mooheadtown"
        Service     = "moo"
        Project     = "moo"
        Environment = "dev"
    }
    
    vpc_peering_accept_create = [{
        index                     = "insilico-dev-isp"
        vpc_peering_connection_id = "pcx-09ac981e0444b5xxx"
        auto_accept               = true
    }]
}

```