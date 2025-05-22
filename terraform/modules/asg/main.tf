# Creating an Auto Scaling Group managing EC2 instance fleet:
resource "aws_autoscaling_group" "web" {
  name                      = "${var.name_prefix}-web-asg"
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  desired_capacity          = var.asg_desired_capacity
  health_check_type         = "ELB"
  health_check_grace_period = var.asg_health_check_grace_period

  # Linking ASG to Launch Template defined above:
  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  # Placing instances in the public subnets created in VPC:
  vpc_zone_identifier = var.public_subnet_ids

  # Registering instances with the ALB target group:
  target_group_arns = var.target_group_arns

  # Tagging instances launched by this ASG:
  tag {
    key                 = "Name"
    value               = "${var.name_prefix}-web-instance"
    propagate_at_launch = true
  }
}