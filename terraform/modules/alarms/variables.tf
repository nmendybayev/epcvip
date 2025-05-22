variable "name_prefix" {
  description = "Prefix for resource naming"
  type        = string
}

variable "scale_out_adjustment" {
  description = "Number of instances to add on scale out"
  type        = number
}

variable "scale_in_adjustment" {
  description = "Number of instances to remove on scale in"
  type        = number
}

variable "scale_cooldown" {
  description = "Cooldown period in seconds for scaling actions"
  type        = number
}

variable "metric_period" {
  description = "CloudWatch metric period in seconds"
  type        = number
}

variable "cpu_high_threshold" {
  description = "CPU Utilization threshold (%) to trigger scale out"
  type        = number
}

variable "cpu_low_threshold" {
  description = "CPU Utilization threshold (%) to trigger scale in"
  type        = number
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group to attach policies and alarms"
  type        = string
}