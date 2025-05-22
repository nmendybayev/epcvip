output "ec2_instance_profile_name" {
  value       = aws_iam_instance_profile.ec2_profile.name
  description = "IAM Instance Profile name for EC2 instances"
}