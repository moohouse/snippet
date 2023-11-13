# AWS IAM Policy module

# Usage 
```
module "iam-policy" {
    source = "../../../../modules/module-aws-iam-policy"
    
    iam_policy_create = [{
        index   = "iam_policy1"
        policy_name = "AWSServiceRoleForAmazonEKS"
        policy  = "./test_custom_policy.json
    },
    {
        index   = "iam_policy2"
        policy_name = "AWSServiceRoleForAmazonEKS2"
        policy  = "./test_custom_policy.json" 
    }]
    common_tags = {
        Company     = "Mooheadtown"
        Service     = "moo"
        Project     = "moo"
        Environment = "dev"
    }

}
```