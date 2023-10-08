resource "aws_lb" "main" {
  name               = "${var.project_name}-${var.environment}"
  security_groups    = var.alb_sg
  subnets            = var.subnets
  load_balancer_type = "application"
  idle_timeout       = 1800
  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "web" {
  name                 = "${var.project_name}-${var.environment}"
  port                 = 443
  protocol             = "HTTPS"
  vpc_id               = var.vpc_id
  deregistration_delay = 30

  health_check {
    path                = "/healthcheck"
    protocol            = "HTTPS"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
  }
}

resource "aws_lb_target_group_attachment" "web" {
  port             = 443
  target_group_arn = aws_lb_target_group.web.arn
  target_id        = var.web_instance_id
}

resource "aws_lb_listener" "web" {
  port              = "8080"
  protocol          = "HTTP"
  #ssl_policy        = var.aws_lb_parameters.project_ssl_policy
  #certificate_arn   = var.acm_arn
  load_balancer_arn = aws_lb.main.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

resource "aws_lb_listener" "web_http" {
  load_balancer_arn = aws_lb.main.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}