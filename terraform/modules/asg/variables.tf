variable "name_prefix" {
  description = "Prefix for resource naming"
  type        = string
}

variable "asg_max_size" {
  description = "Maximum size of the Auto Scaling Group"
  type        = number
}

variable "asg_min_size" {
  description = "Minimum size of the Auto Scaling Group"
  type        = number
}

variable "asg_desired_capacity" {
  description = "Desired capacity of the Auto Scaling Group"
  type        = number
}

variable "asg_health_check_grace_period" {
  description = "Health check grace period (seconds) for the ASG"
  type        = number
}

variable "launch_template_id" {
  description = "ID of the launch template to use"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "target_group_arns" {
  description = "List of ARNs for ALB Target Groups"
  type        = list(string)
}