
# NAT Gateway & NAT EIP
# Usage
```
module "nat" {
    source = "../../../modules/module-aws-nat"
    
    nat_create         = [{ 
        index          = "sbn1-nat"
        type           = "nat"
        sub_index      = "sbn1"
        networkboudary = "pub"
    }]
    
    subnet_info = data.terraform_remote_state.remote.outputs.subnet_info
    
    common_tags  = {
        Company     = "SG"
        Service     = "isp"
        Project     = "wisdom"
        Environment = "dev"
    }
}

