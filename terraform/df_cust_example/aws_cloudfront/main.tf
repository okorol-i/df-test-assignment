locals {
  name = "${var.project}-${var.env}"

  common_tags = tomap({
    Environment = "${var.project}-${var.env}"
    Owner       = "${var.project}-devops-team"
    Billing     = "${var.project}-${var.env}"
    Automation  = "terraform"
    Created     = formatdate("YYYY.MM.DD-hh:mm:ss", timestamp())
  })

  s3_bucket_arn = try(data.terraform_remote_state.s3.outputs.bucket_arn, null)
}

resource "time_static" "main" {}

module "cloudfront" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "6.4.0"

  comment = "df ${var.env} cloudfront distribution"

  enabled           = true
  http_version      = "http2and3"
  is_ipv6_enabled   = true
  price_class       = try(var.aws_cloudfront.df_example_cloudfront.price_class, "PriceClass_100")
  default_root_object = try(var.aws_cloudfront.df_example_cloudfront.default_root_object, "index.html")

  viewer_certificate = {
    cloudfront_default_certificate = true
  }

  origin_access_control = {
    s3 = {
      description      = "CloudFront access to S3"
      origin_type      = "s3"
      signing_behavior = "always"
      signing_protocol = "sigv4"
    }
  }

  origin = {
    alb = {
      domain_name = data.terraform_remote_state.alb.outputs.alb_dns_name
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "http-only"
        origin_ssl_protocols   = ["TLSv1.2"]
      }
    }

    s3 = {
      domain_name               = data.terraform_remote_state.s3.outputs.bucket_regional_domain_name
      origin_access_control_key = "s3"
    }
  }

  default_cache_behavior = {
    target_origin_id       = "alb"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]

    cache_policy_name          = "Managed-CachingDisabled"
    origin_request_policy_name = "Managed-AllViewer"

    compress = true
  }

  ordered_cache_behavior = [
    {
      path_pattern           = "/static/*"
      target_origin_id       = "s3"
      viewer_protocol_policy = "redirect-to-https"

      allowed_methods = ["GET", "HEAD", "OPTIONS"]
      cached_methods  = ["GET", "HEAD"]

      cache_policy_name          = "Managed-CachingOptimized"
      origin_request_policy_name = "Managed-CORS-S3Origin"
      compress                    = true
    }
  ]

  restrictions = {
    geo_restriction = {
      restriction_type = "none"
    }
  }

  tags = local.common_tags
}

data "aws_iam_policy_document" "s3_bucket_policy" {
  statement {
    sid    = "AllowCloudFrontServicePrincipalReadOnly"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = ["s3:GetObject"]
    resources = [
      "${local.s3_bucket_arn}/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values = [module.cloudfront.cloudfront_distribution_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = data.terraform_remote_state.s3.outputs.bucket_name
  policy = data.aws_iam_policy_document.s3_bucket_policy.json
}

