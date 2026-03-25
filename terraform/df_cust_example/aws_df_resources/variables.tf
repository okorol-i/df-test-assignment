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

variable "aws_network" {
  type        = any
  description = "Object with VPC/subnet CIDR settings"
}

variable "aws_ec2" {
  type        = any
  description = "Object with EC2/AMI/SSH settings"
}

variable "aws_s3" {
  type        = any
  description = "Object with S3 static bucket settings"
}

variable "aws_cloudfront" {
  type        = any
  description = "Object with CloudFront behavior settings"
}