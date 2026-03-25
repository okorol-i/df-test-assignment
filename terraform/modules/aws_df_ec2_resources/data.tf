data "aws_caller_identity" "current" {}

data "aws_ec2_managed_prefix_list" "cloudfront_origin_facing" {
  name = "com.amazonaws.global.cloudfront.origin-facing"
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "amazon_linux_2023" {
  count       = try(var.aws_ec2.ami_id, null) == null ? 1 : 0
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

data "aws_cloudfront_cache_policy" "alb_caching_disabled" {
  name = "Managed-CachingDisabled"
}

data "aws_cloudfront_origin_request_policy" "alb_all_viewer" {
  name = "Managed-AllViewer"
}

data "aws_cloudfront_cache_policy" "static_optimized" {
  name = "Managed-CachingOptimized"
}

data "aws_cloudfront_origin_request_policy" "s3_cors" {
  name = "Managed-CORS-S3Origin"
}
