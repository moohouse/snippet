# AWS backend module

# Usage 
```
module "backend" {
 source = "/modules/module-aws-backend"
 bucket_sse_algorithm = "AES256"

 common_tags         = {
  Company     = "Mooheadtown"
  Service     = "moo"
  Project     = "moo"
  Environment = "dev"
 }
}
```