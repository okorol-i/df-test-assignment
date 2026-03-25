resource "aws_cloudfront_origin_access_control" "s3_oac" {
  name                              = "${local.name_prefix}-oac"
  description                       = "CloudFront access to bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "frontend_cdn" {
  enabled             = true
  default_root_object = try(var.aws_cloudfront.default_root_object, "index.html")
  price_class         = try(var.aws_cloudfront.price_class, "PriceClass_100")

  origin {
    domain_name = aws_lb.frontend.dns_name
    origin_id   = "alb-frontend"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  origin {
    domain_name              = aws_s3_bucket.frontend_static.bucket_regional_domain_name
    origin_id                = "frontend-s3-origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.s3_oac.id
  }

  default_cache_behavior {
    allowed_methods          = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods           = ["GET", "HEAD"]
    target_origin_id         = "alb-frontend"
    viewer_protocol_policy   = "redirect-to-https"
    compress                 = true
    cache_policy_id          = data.aws_cloudfront_cache_policy.alb_caching_disabled.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.alb_all_viewer.id
  }

  ordered_cache_behavior {
    path_pattern             = "/static/*"
    allowed_methods          = ["GET", "HEAD", "OPTIONS"]
    cached_methods           = ["GET", "HEAD"]
    target_origin_id         = "frontend-s3-origin"
    viewer_protocol_policy   = "redirect-to-https"
    compress                 = true
    cache_policy_id          = data.aws_cloudfront_cache_policy.static_optimized.id
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.s3_cors.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = merge(var.tags, { Name = "${local.name_prefix}-frontend-cdn" })
}

resource "aws_s3_bucket_policy" "frontend_static_policy" {
  bucket = aws_s3_bucket.frontend_static.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Sid       = "AllowCloudFrontServicePrincipalReadOnly",
      Effect    = "Allow",
      Principal = { Service = "cloudfront.amazonaws.com" },
      Action    = ["s3:GetObject"],
      Resource  = "${aws_s3_bucket.frontend_static.arn}/*",
      Condition = {
        StringEquals = {
          "AWS:SourceArn" = aws_cloudfront_distribution.frontend_cdn.arn
        }
      }
    }]
  })
}
