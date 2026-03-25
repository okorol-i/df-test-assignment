resource "aws_s3_bucket" "frontend_static" {
  bucket_prefix = "${try(var.aws_s3.bucket_prefix, "${local.name_prefix}-frontend-static")}-"
  force_destroy = try(var.aws_s3.force_destroy, false)
  tags          = merge(var.tags, { Name = "${local.name_prefix}-frontend-static" })
}

resource "aws_s3_bucket_public_access_block" "frontend_static" {
  bucket                  = aws_s3_bucket.frontend_static.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
