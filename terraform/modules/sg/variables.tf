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