variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "iam_user_name" {
  description = "IAM user to attach backend access policy"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for resource naming"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_count" {
  description = "Number of public subnets"
  type        = number
}

variable "http_port" {
  description = "HTTP port to open in security groups"
  type        = number
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "asg_max_size" {
  description = "Max size of Auto Scaling Group"
  type        = number
}

variable "asg_min_size" {
  description = "Min size of Auto Scaling Group"
  type        = number
}

variable "asg_desired_capacity" {
  description = "Desired capacity of Auto Scaling Group"
  type        = number
}

variable "asg_health_check_grace_period" {
  description = "Health check grace period for ASG"
  type        = number
}

variable "scale_out_adjustment" {
  description = "Scale out adjustment for alarms"
  type        = number
}

variable "scale_in_adjustment" {
  description = "Scale in adjustment for alarms"
  type        = number
}

variable "scale_cooldown" {
  description = "Cooldown period for scaling"
  type        = number
}

variable "metric_period" {
  description = "Period for CloudWatch metric evaluation"
  type        = number
}

variable "cpu_high_threshold" {
  description = "CPU threshold for scale-out"
  type        = number
}

variable "cpu_low_threshold" {
  description = "CPU threshold for scale-in"
  type        = number
}



# To use an S3 remote backend with DynamoDB state locking, uncomment block below (check user permissions first)

# variable "backend_s3_bucket" {
#   description = "S3 bucket name for Terraform remote state backend"
#   type        = string
# }

# variable "backend_dynamodb_table" {
#   description = "DynamoDB table name for Terraform state locking"
#   type        = string
# }