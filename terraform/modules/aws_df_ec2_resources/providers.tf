terraform {
  required_providers {
    aws = {
      version = ">= 6.11.0"
      source  = "hashicorp/aws"
    }
  }
  required_version = "~> 1.12.2"
}