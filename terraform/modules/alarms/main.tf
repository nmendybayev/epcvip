# Creating scale-out policy to add 1 instance when triggered:
resource "aws_autoscaling_policy" "scale_out" {
  name                   = "${var.name_prefix}-scale-out"
  scaling_adjustment     = var.scale_out_adjustment
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.scale_cooldown  # Cooldown period to avoid rapid scaling
  autoscaling_group_name = var.asg_name
  policy_type            = "SimpleScaling"
}

# Creating scale-in policy to remove 1 instance when triggered:
resource "aws_autoscaling_policy" "scale_in" {
  name                   = "${var.name_prefix}-scale-in"
  scaling_adjustment     = var.scale_in_adjustment
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.scale_cooldown
  autoscaling_group_name = var.asg_name
  policy_type            = "SimpleScaling"
}

# Creating CloudWatch alarm to trigger scale out when average CPU > 70% for 5 minutes:
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${var.name_prefix}-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.metric_period
  statistic           = "Average"
  threshold           = var.cpu_high_threshold
  alarm_description   = "Scale out if CPU > ${var.cpu_high_threshold}% for 5 minutes"

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }

  alarm_actions = [aws_autoscaling_policy.scale_out.arn]
}

# Creating CloudWatch alarm to trigger scale in when average CPU < 30% for 5 minutes:
resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "${var.name_prefix}-cpu-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.metric_period
  statistic           = "Average"
  threshold           = var.cpu_low_threshold
  alarm_description   = "Scale in if CPU < ${var.cpu_low_threshold}% for 5 minutes"

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }

  alarm_actions = [aws_autoscaling_policy.scale_in.arn]
}