
# AWS route53 module

# Usage 
```
module "route53" {
    source = "../../../modules/module-aws-route53"
    
    hostzone_create = [
    { 
        index = "hostzone-1"
        name  = "test.com"
    }]
    
    record_create = [
        { 
            index      = "record1"
            zone_index = "hostzone-1"
            name       = "www"
            type       = "A"
            ttl        = 300 ## alias 아닐 경우 ttl 필수
            records    = ["123.456.78.910"]
        },
        { 
            index      = "record2"
            zone_index = "hostzone-1"
            name       = "terraform.test.com"
            type       = "A"
            alias = [{
                name    = "dualstack.a12345678.ap-northeast-2.elb.amazonaws.com"
            zone_id = "ZZZZZZZZZZZ"
            evaluate_target_health = true 
        }]
    }]
    
    vpc_info            = data.terraform_remote_state.remote.outputs.vpc_info
    
    common_tags = {
        Company     = "Mooheadtown"
        Service     = "moo"
        Project     = "moo"
        Environment = "dev"
    }
}


```
