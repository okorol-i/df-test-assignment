resource "aws_security_group" "alb" {
  name_prefix = "${local.name_prefix}-alb-"
  description = "Exposed ALB for traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "HTTP for CloudFront traffic"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    prefix_list_ids = [data.aws_ec2_managed_prefix_list.cloudfront_origin_facing.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "${local.name_prefix}-alb-sg" })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb" "frontend" {
  name               = "${local.name_prefix}-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [aws_subnet.public_frontend.id, aws_subnet.public_secondary.id]

  tags = merge(var.tags, { Name = "${local.name_prefix}-alb" })
}

resource "aws_lb_target_group" "frontend" {
  name        = "${local.name_prefix}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"

  health_check {
    enabled             = true
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200-399"
  }

  tags = merge(var.tags, { Name = "${local.name_prefix}-frontend-tg" })
}

resource "aws_lb_listener" "frontend_http" {
  load_balancer_arn = aws_lb.frontend.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }
}

resource "aws_lb_target_group_attachment" "frontend_ec2" {
  target_group_arn = aws_lb_target_group.frontend.arn
  target_id        = aws_instance.frontend.id
  port             = 80
}
