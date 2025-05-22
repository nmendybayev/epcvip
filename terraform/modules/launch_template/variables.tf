variable "name_prefix" {
  description = "Prefix for resource naming"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID to use for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ec2_sg_ids" {
  description = "List of Security Group IDs for EC2 instances"
  type        = list(string)
}

variable "ec2_instance_profile_name" {
  description = "IAM Instance Profile name for EC2 instances"
  type        = string
}