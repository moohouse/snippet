# AWS subnet module
# Usage 
```
module "subnet" {
    source = "../../../../modules/module-aws-subnet"

    common_tags = {
        Company     = "Mooheadtown"
        Service     = "moo"
        Project     = "moo"
        Environment = "dev"
    }

    subnet_create = [{
        index                    = "sbn1"
        vpc_index                = "moo"
        purpose                 = "bastion"
        type                    = "sbn"
        position                = "public"
        availability_zone       = "ap-northeast-2a"
        cidr_block              = "172.17.0.0/24"
        map_public_ip_on_launch = "true"
    }]
}

```