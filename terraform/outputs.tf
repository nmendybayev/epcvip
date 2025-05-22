# Outputs available on the root-module level:

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "alb_dns_name" {
  value       = module.alb.alb_dns_name
  description = "DNS name of ALB"
}

output "target_group_arn" {
  value       = module.alb.target_group_arn
  description = "ARN of the ALB Target Group"
}