terraform {
  required_version = ">= 1.4.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.60"
    }
  }

  backend "s3" {
    bucket         = "tfstate"
    key            = "iac.state"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "tflock-ddb"
  }

}

provider "aws" {
  region = var.region
}
