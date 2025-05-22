output "alb_dns_name" {
  value       = aws_lb.app_alb.dns_name
  description = "DNS name of ALB"
}

output "target_group_arn" {
  value       = aws_lb_target_group.app_tg.arn
  description = "ARN of the ALB Target Group"
}