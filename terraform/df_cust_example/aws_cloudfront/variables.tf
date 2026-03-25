variable "project" {
  type        = string
  description = "Name of the project"
}

variable "env" {
  type        = string
  description = "Env type: dev, prod, uat, etc."
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region for resource deployment"
}

variable "aws_profile" {
  type        = string
  description = "Optional AWS CLI profile name"
  default     = null
}

variable "aws_cloudfront" {
  type = any
  description = "CloudFront configuration overrides"
}

