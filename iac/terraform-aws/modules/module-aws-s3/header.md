# AWS S3 module

# Usage 
```
module "s3" {
    source = "../../../modules/module-aws-s3"
    
    common_tags = {
        Company     = "Mooheadtown"
        Service     = "moo"
        Project     = "moo"
        Environment = "dev"
    }
    
    s3_create = [{ 
        index = "s3-1"
        service = "isp"
        purpose = "log"
        type = "s3"
        kms_index = "s3-1-kms1" 
        versioning = "Disabled" 
        block_public_acls = true
        block_public_policy = true
        ignore_public_acls = true
        restrict_public_buckets = true
        object_ownership = "BucketOwnerEnforced"
    }]
    
    s3_kms_create = [{ 
        index                   = "s3-1-kms1"
        service                 = "moo"
        purpose                 = "log-s3"
        type                    = "kms"
        description             = "log s3 kms key"
        deletion_window_in_days = 7
    }]
    
    s3_policy_create = [{
        index = "s3-policy-1"
        s3_index = "s3-1"
        bucket_policy = "./s3-log-policy.json"
    }]

    s3_web_create = [{
        index = "s3-web-1"
        s3_index = "s3-1"
        index_document = "index.html"
    }]
    s3_cors_create = [{
        index = "s3-cors1"
        s3_index = "s3-1"
        cors_rule = [{
            allowed_headers = ["*"]
            allowed_methods = ["HEAD","GET","PUT","POST","DELETE"]
            allowed_origins = [ "http://localhost"]
        }]
    }]
}
```
