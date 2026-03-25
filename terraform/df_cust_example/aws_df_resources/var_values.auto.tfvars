project = "df"
env     = "dev"
region  = "us-east-1"

aws_profile = "df-cust-example"

aws_network = {
  vpc_cidr            = "10.10.0.0/16"
  public_subnet_cidr  = "10.10.1.0/24"
  backend_subnet_cidr = "10.10.2.0/24"
  db_subnet_cidr      = "10.10.3.0/24"
}

aws_ec2 = {
  frontend_instance_type = "t3.micro"
  backend_instance_type  = "t3.micro"
  db_instance_type       = "t3.micro"
  key_name               = null
  ami_id                 = null
  ssh_ingress_cidr       = "0.0.0.0/0"
}

aws_s3 = {
  bucket_prefix = "df-dev-frontend-static"
  force_destroy = false
}

aws_cloudfront = {
  default_root_object = "index.html"
  price_class         = "PriceClass_100"
}
