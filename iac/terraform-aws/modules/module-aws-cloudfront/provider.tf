terraform {

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 4.60"
      configuration_aliases = [aws.alternate] # aws.alter는 module이 선언한 alias. 여기에 main.tf의 providers에서 provider.tf에서 선언한 alias를 적용함.
    }
  }
}
