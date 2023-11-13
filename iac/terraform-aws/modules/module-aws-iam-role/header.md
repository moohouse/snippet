# AWS IAM Role module

# Usage 
```
module "iam-policy" {
    source = "../../../../modules/module-aws-iam-role"
    
    iam_role_create = [{
        index  = "iam_role1"
        role_name = "test_role"
        assume_role_policy = "./assume_role_policy.json" #Root 모듈에 assume_role에 해당하는 json 파일 생성하여 경로 명시
    }]
    
    iam_managed_policy_attatch_create = [{
        index   = "managed_policy1"
        managed_policy_name = "CloudFrontReadOnlyAccess"
        iam_role_index = "iam_role1"
    },
    {
        index   = "managed_policy2"
        managed_policy_name = "AmazonEC2FullAccess"  
        iam_role_index = "iam_role1"
    }]
    
    iam_custom_policy_attatch_create = [{
        index   = "custom_policy2"
        iam_policy_index = "iam_policy2"  
        iam_role_index = "iam_role1"
    }]
    
    common_tags = {
        Company     = "Mooheadtown"
        Service     = "moo"
        Project     = "moo"
        Environment = "dev"
    }
    
    iam_policy_info = module.iam-policy.iam_policy_info  
}
```