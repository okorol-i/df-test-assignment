resource "time_static" "main" {}

locals {
  name = "${var.project}-${var.env}"
  common_tags = tomap({
    Environment = "${var.project}-${var.env}"
    Owner       = "${var.project}-devops-team"
    Billing     = "${var.project}-${var.env}"
    Automation  = "terraform"
    Created     = formatdate("YYYY.MM.DD-hh:mm:ss", time_static.main.rfc3339)
  })
}

module "df_example_module" {
  source = "../../modules/aws_df_ec2_resources"

  project = var.project
  env     = var.env
  region  = var.region

  aws_network    = var.aws_network
  aws_ec2        = var.aws_ec2
  aws_s3         = var.aws_s3
  aws_cloudfront = var.aws_cloudfront

  tags = local.common_tags
}
