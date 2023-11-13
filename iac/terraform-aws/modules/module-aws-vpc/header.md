# AWS VPC module

# Usage 
```
module "vpc" {
    source = "../../../../modules/module-aws-route-vpc"
    common_tags = {
        Company     = "Mooheadtown"
        Service     = "moo"
        Project     = "moo"
        Environment = "dev"
    }

    vpc_create = [{
        index                = "dev"
        type                 = "vpc"
        cidr_block           = "172.17.0.0/16"
        secondary_cidr_block = null
        instance_tenancy     = "default"
        enable_dns_hostnames = "true"
        enable_dns_support   = "true"
        enable_ipv6          = "false"
        aws_internet_gateway = true
    }]
}
```

