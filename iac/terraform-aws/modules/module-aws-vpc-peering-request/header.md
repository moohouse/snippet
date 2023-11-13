# AWS vpc peering request module

# Usage 
```
module "vpc-peering-request" {
    source = "../../../../modules/module-aws-vpc-peering-request"
    
    common_tags = {
        Company     = "Mooheadtown"
        Service     = "moo"
        Project     = "moo"
        Environment = "dev"
    }
    
    vpc_peering_request_create = [{
        index                = "moo"
        peer_owner_id        = "123456789012"  
        peer_vpc_id          = "vpc-1234567890" 
        vpc_index            = "moo" 
        auto_accept          = false 
    }]
}

```