resource "aws_instance" "frontend" {
  ami                         = local.ami_to_use
  instance_type               = try(var.aws_ec2.frontend_instance_type, "t3.micro")
  subnet_id                   = aws_subnet.public_frontend.id
  key_name                    = try(var.aws_ec2.key_name, null)
  vpc_security_group_ids      = [aws_security_group.frontend.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  associate_public_ip_address = true

  tags = merge(var.tags, { Name = "${local.name_prefix}-frontend-ec2" })
}

resource "aws_instance" "backend" {
  ami                    = local.ami_to_use
  instance_type          = try(var.aws_ec2.backend_instance_type, "t3.micro")
  subnet_id              = aws_subnet.private_backend.id
  key_name               = try(var.aws_ec2.key_name, null)
  vpc_security_group_ids = [aws_security_group.backend.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  tags = merge(var.tags, { Name = "${local.name_prefix}-backend-ec2" })
}

resource "aws_instance" "db" {
  ami                    = local.ami_to_use
  instance_type          = try(var.aws_ec2.db_instance_type, "t3.micro")
  subnet_id              = aws_subnet.private_db.id
  key_name               = try(var.aws_ec2.key_name, null)
  vpc_security_group_ids = [aws_security_group.db.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  tags = merge(var.tags, { Name = "${local.name_prefix}-postgres-ec2" })
}
