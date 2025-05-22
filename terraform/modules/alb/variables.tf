variable "name_prefix" {
  description = "Prefix for resource naming"
  type        = string
}

variable "http_port" {
  description = "Port for HTTP traffic"
  type        = number
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "alb_sg_ids" {
  description = "List of Security Group IDs for the ALB"
  type        = list(string)
}
