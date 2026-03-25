resource "time_static" "main" {}

locals {
  name = "${var.project}-${var.env}"

  bucket_name = "${local.name}-frontend-static-${data.aws_caller_identity.current.account_id}"

  common_tags = tomap({
    Environment = "${var.project}-${var.env}"
    Owner       = "${var.project}-devops-team"
    Billing     = "${var.project}-${var.env}"
    Automation  = "terraform"
    Created     = formatdate("YYYY.MM.DD-hh:mm:ss", time_static.main.rfc3339)
    Account     = data.aws_caller_identity.current.account_id
  })
}

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.2.0"

  bucket        = local.bucket_name
  force_destroy = try(var.aws_s3.frontend_static.force_destroy, true)
  versioning    = try(var.aws_s3.frontend_static.versioning, { enabled = true })

  control_object_ownership = try(var.aws_s3.frontend_static.control_object_ownership, true)
  object_ownership         = try(var.aws_s3.frontend_static.object_ownership, "ObjectWriter")

  block_public_acls       = try(var.aws_s3.frontend_static.block_public_acls, true)
  block_public_policy     = try(var.aws_s3.frontend_static.block_public_policy, true)
  ignore_public_acls      = try(var.aws_s3.frontend_static.ignore_public_acls, true)
  restrict_public_buckets = try(var.aws_s3.frontend_static.restrict_public_buckets, true)

  attach_policy      = false
  attach_public_policy = false

  tags = local.common_tags
}

