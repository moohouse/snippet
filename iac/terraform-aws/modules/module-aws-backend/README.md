<!-- BEGIN_TF_DOCS -->
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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_sse_algorithm"></a> [bucket\_sse\_algorithm](#input\_bucket\_sse\_algorithm) | Encryption algorithm to use on the S3 bucket. Currently only AES256 is supported | `string` | n/a | yes |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | whole resource take this tags to common | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dynamo_lock_table"></a> [dynamo\_lock\_table](#output\_dynamo\_lock\_table) | n/a |
| <a name="output_state_bucket_arn"></a> [state\_bucket\_arn](#output\_state\_bucket\_arn) | n/a |
<!-- END_TF_DOCS -->
| Name | Description |
|------|-------------|
| <a name="output_dynamo_lock_table"></a> [dynamo\_lock\_table](#output\_dynamo\_lock\_table) | n/a |
| <a name="output_state_bucket_arn"></a> [state\_bucket\_arn](#output\_state\_bucket\_arn) | n/a |
<!-- END_TF_DOCS -->