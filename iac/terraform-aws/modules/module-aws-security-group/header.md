# AWS security group module

# Usage 
```
module "security-group" {
    source = "../../../../modules/module-aws-security-group"
    
    common_tags = {
        Company     = "Mooheadtown"
        Service     = "moo"
        Project     = "moo"
        Environment = "dev"
    }
    
    sg_rule_data = [{
        "description" = "OpenVPN"
        "from_port" = "1194"
        "name" = "OpenVPN"
        "position" = "pub"
        "protocol" = "udp"
        "purpose" = "bastion"
        "source" = "0.0.0.0/0"
        "src_sg" = ""
        "to_port" = "1194"
        "type" = "ingress"
        "vpc" = "dev"
    }]
}
```