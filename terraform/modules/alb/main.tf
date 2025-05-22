# Creating the Application Load Balancer (ALB):
resource "aws_lb" "app_alb" {
  name               = "${var.name_prefix}-app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.alb_sg_ids
  subnets            = var.public_subnet_ids


  enable_deletion_protection = false

  tags = {
    Name = "${var.name_prefix}-app-alb"
  }
}

# Creating a Target Group for ALB HTTP traffic on port 80:
resource "aws_lb_target_group" "app_tg" {
  name     = "${var.name_prefix}-app-tg"
  port     = var.http_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  # wasn't in the task but added as the best practice: 
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"
    matcher             = "200"
  }

  tags = {
    Name = "${var.name_prefix}-app-tg"
  }
}

# Creating an ALB Listener on port 80 that forwards requests to the target group:
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = var.http_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}