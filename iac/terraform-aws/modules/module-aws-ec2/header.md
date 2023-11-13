
# AWS ec2 module

# Usage 
```
module "ec2" {
    source = "../../../modules/module-aws-ec2"

    ec2_create  = [{
        index = "ec2-1"
        ami = "ami-03db74b70e1da9c56"
        instance_type = "t2.micro"
        sub_index = "sbn1"
        sg_index = ["bastion"]
        volume_size = 8
        volume_type = "gp3"
        network_boundary = "pub"
        purpose = "bastion"
        region_az = "az2a"
        type = "ec2"
        instance_profile_index = "ec2-1"
    }]

    iam_create = [{
        index = "ec2-1"
        purpose = "test"
    }]

    iam_policy_create = [{
        index = "policy-1"
        purpose = "s3"
        policy = "./iam-policy.json"
    }]

    iam_policy_attach  = [{
        index = "attach-1"
        iam_index = "ec2-1"
        custom_policy_index = "policy-1"
    },
    {
        index = "attach-2"
        iam_index = "ec2-1"
        policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
    }]

    common_tags = {
        Company     = "Mooheadtown"
        Service     = "moo"
        Project     = "moo"
        Environment = "dev"
    }

    vpc_info    = data.terraform_remote_state.remote.outputs.vpc_info
    subnet_info = data.terraform_remote_state.remote.outputs.subnet_info

}

```
