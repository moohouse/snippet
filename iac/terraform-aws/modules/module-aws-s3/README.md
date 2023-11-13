<!-- BEGIN_TF_DOCS -->

# AWS S3 module
##### S3를 생성하는 모듈입니다.

# Usage
```
module "s3" {
  source = "../../../modules/module-aws-s3"

common_tags = {
 Company     = "SG"
 Service     = "isp"
 Project     = "wisdom"
 Environment = "dev"
}

s3_create = [
  { index = "s3-1"
    service = "isp"
    purpose = "log"
    type = "s3"
    kms_index = "s3-1-kms1" # cmk 사용하지 않을 경우 : null or 해당 line 삭제
    versioning = "Disabled" #Enabled or Disabled or Suspend
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
    object_ownership = "BucketOwnerEnforced"

  }
]

#### CMK - optional ####

s3_kms_create = [
  { index                   = "s3-1-kms1"
    service                 = "isp"
    purpose                 = "log-s3"
    type                    = "kms"
    description             = "log s3 kms key"
    deletion_window_in_days = 7

  }
]

#### bucket policy - optional ####

s3_policy_create = [
  {index = "s3-policy-1"
   s3_index = "s3-1"
   bucket_policy = "./s3-log-policy.json"
  }
]
}

#### bucket web hosting - optional ####

s3_web_create = [
  {index = "s3-web-1"
  s3_index = "s3-1"
  index_document = "index.html"
  }
 ]

 #### bucket CORS - optional ####

s3_cors_create = [
  { index = "s3-cors1"
    s3_index = "s3-1"
    cors_rule = [
      {
        allowed_headers = ["*"]
        allowed_methods = ["HEAD","GET","PUT","POST","DELETE"]
        allowed_origins = [ "http://localhost:3000",
                            "http://localhost:3020",
                            "http://localhost:3030"]
      }
    ]
  }
]

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | whole resource take this tags to common | `map(any)` | n/a | yes |
| <a name="input_s3_cors_create"></a> [s3\_cors\_create](#input\_s3\_cors\_create) | Defined s3 cors  configuration option values | `any` | `[]` | no |
| <a name="input_s3_create"></a> [s3\_create](#input\_s3\_create) | Defined s3 configuration option values | `any` | n/a | yes |
| <a name="input_s3_kms_create"></a> [s3\_kms\_create](#input\_s3\_kms\_create) | Defined s3 kms key configuration option values | `any` | `[]` | no |
| <a name="input_s3_policy_create"></a> [s3\_policy\_create](#input\_s3\_policy\_create) | Defined s3 bucket policy configuration option values | `any` | `[]` | no |
| <a name="input_s3_web_create"></a> [s3\_web\_create](#input\_s3\_web\_create) | Defined s3 web site  configuration option values | `any` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_s3_bucket_info"></a> [s3\_bucket\_info](#output\_s3\_bucket\_info) | s3 bucket information map type output. |
| <a name="output_s3_kms_info"></a> [s3\_kms\_info](#output\_s3\_kms\_info) | s3 kms key information map type output. |
| <a name="output_s3_web_info"></a> [s3\_web\_info](#output\_s3\_web\_info) | s3 web site information map type output. |
<!-- END_TF_DOCS -->