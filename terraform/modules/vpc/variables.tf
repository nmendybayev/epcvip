variable "vpc_cidr" {
  description = "CIDR block for the main VPC"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for resource naming"
  type        = string
}

variable "public_subnet_count" {
  description = "Number of public subnets to create"
  type        = number
}