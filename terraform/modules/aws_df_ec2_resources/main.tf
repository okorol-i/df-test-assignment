locals {
  name_prefix = "${var.project}-${var.env}"
  ami_to_use  = try(var.aws_ec2.ami_id, null) != null ? var.aws_ec2.ami_id : data.aws_ami.amazon_linux_2023[0].id
}
