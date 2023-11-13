# AWS route-table module

# Usage 
```
module "aws_route-table" {
    source = "../../../../modules/module-aws-route-table"
    common_tags = {
        Company     = "Mooheadtown"
        Service     = "moo"
        Project     = "moo"
        Environment = "dev"
    }
    
    subnet_create = [{
        index                    = "sbn1"
        vpc_index                = "moo_dev"
        purpose                 = "bastion"
        type                    = "sbn"
        position                = "public"
        availability_zone       = "ap-northeast-2a"
        cidr_block              = "10.17.0.0/24"
        map_public_ip_on_launch = "true"
    }]
    
    rt_rule_data = [{
        "description" = ""
        "dst_cidr" = "0.0.0.0/0"
        "igw" = "insilico_dev"
        "nat" = ""
        "pcx" = ""
        "pl" = ""
        "sub_index" = "sbn1"
        "tgw" = ""
        "vpc" = "insilico_dev"
        "vpce" = ""
    }]
}

```
