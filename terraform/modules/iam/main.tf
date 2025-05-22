# Creating IAM Role for EC2 to push logs to CloudWatch:
resource "aws_iam_role" "ec2_instance_role" {
  name = "${var.name_prefix}-web-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attaching AWS-managed policy for CloudWatch Agent:
resource "aws_iam_role_policy_attachment" "cloudwatch_logs" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Creating an instance profile so EC2 can assume the role:
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.name_prefix}-web-instance-profile"
  role = aws_iam_role.ec2_instance_role.name
}