terraform {
  required_version = ">= 1.4.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.66.0"
    }
  }
  backend "s3" {
    bucket         = "tfstate"       ## backend 전용 s3 bucket name
    key            = "isp/rds.state" ## 경로. state file 저장될 이름.
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "tflock-ddb" ## backend 전용 dynamoDB name
  }

}



provider "aws" {
  region = "ap-northeast-2"
}
