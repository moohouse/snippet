variable "region" {
  default = "ap-northeast-2"
}

variable "common_tags" {
  description = "whole resource take this tags to common"
  type        = map(any)
}