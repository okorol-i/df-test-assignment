project = "df"
env     = "dev"

# in case of more buckets expand with each in main.tf
aws_s3 = {
  frontend_static = {
    bucket_prefix = "df-${env}-frontend-static"
    force_destroy = true
    versioning     = { enabled = true }
    object_ownership = "ObjectWriter"
    control_object_ownership = true
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }
}

