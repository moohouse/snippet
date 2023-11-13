
# AWS bastion ec2 module

# Usage 
```
module "ec2-bastion" {
    source = "../../../modules/module-aws-ec2-bastion"

    common_tags = {
        Company     = "Mooheadtown"
        Service     = "moo"
        Project     = "moo"
        Environment = "dev"
    }
    
    ec2_bastion_create = [{
        index = "ec2-bastion"
        ami = "ami-03db74b70e1da9c56"
        instance_type = "t2.micro"
        sub_index = "sbn1"
        sg_index = ["dev_bastion_pub"]
        volume_size = 8
        volume_type = "gp3"
        
        network_boundary = "pub"
        purpose = "bastion"
        region_az = "apne2a"
        type = "ec2"
    }]
    
    vpc_info    = data.terraform_remote_state.remote.outputs.vpc_info
    subnet_info = data.terraform_remote_state.remote.outputs.subnet_info

}

```
