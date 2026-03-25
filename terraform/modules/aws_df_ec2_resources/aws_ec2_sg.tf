resource "aws_security_group" "frontend" {
  name        = "${local.name_prefix}-frontend-sg"
  description = "Frontend app access"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  ingress {
    description = "SSH for instance debug"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [try(var.aws_ec2.ssh_ingress_cidr, "0.0.0.0/0")]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "${local.name_prefix}-frontend-sg" })
}

resource "aws_security_group" "backend" {
  name        = "${local.name_prefix}-backend-sg"
  description = "Allow backend app traffic from frontend and SSH"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 8000
    to_port         = 8000
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [try(var.aws_ec2.ssh_ingress_cidr, "0.0.0.0/0")]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "${local.name_prefix}-backend-sg" })
}

resource "aws_security_group" "db" {
  name        = "${local.name_prefix}-db-sg"
  description = "Allow PostgreSQL traffic from backend and SSH"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.backend.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [try(var.aws_ec2.ssh_ingress_cidr, "0.0.0.0/0")]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "${local.name_prefix}-db-sg" })
}
