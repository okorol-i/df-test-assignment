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
  description = "AWS region for resource deployment"
}

variable "aws_network" {
  type        = any
  description = "Object with VPC and subnet CIDR settings"
}

variable "aws_ec2" {
  type        = any
  description = "Object with instance types and access settings"
}

variable "aws_s3" {
  type        = any
  description = "Object with S3 frontend static bucket settings"
}

variable "aws_cloudfront" {
  type        = any
  description = "Object with CloudFront settings"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to resources"
  default     = {}
}