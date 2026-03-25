terraform {
  required_version = "~> 1.12.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.11.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.13.0"
    }
  }
    # example for state storage
  /*
  backend "s3" {
    bucket  = "example-use1-s3"
    key     = "terraform/client/aws_cloudfront.state"
    region  = "us-east-1"
    profile = "df-svc-root"
  }
  */
}

provider "aws" {
  region  = "us-east-1"
  profile = "df-cust-example"
}

