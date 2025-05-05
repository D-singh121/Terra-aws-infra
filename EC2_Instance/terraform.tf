terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.97.0"
    }
  }

  # remote backend state management for terraform with dynamoDb and s3 bucket on aws.
  # sabse pahle terraform ek dynamodb table aur s3 create kar lena hai.
  backend "s3" {
    bucket         = "my-tf-state-bucket-dsingh-20250505"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "RemoteInfraStateDB"
    use_lockfile   = true
  }
}
