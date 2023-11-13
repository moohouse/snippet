variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)

}

variable "bucket_sse_algorithm" {
  type        = string
  description = "Encryption algorithm to use on the S3 bucket. Currently only AES256 is supported"
}
