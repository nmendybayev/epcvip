# Creating a Launch Template defining EC2 instance configuration for ASG:
resource "aws_launch_template" "web" {
  name_prefix   = "${var.name_prefix}-web-lt"
  image_id      = var.ami_id
  instance_type = var.instance_type

  # For CloudWatch role:
  iam_instance_profile {
    name = var.ec2_instance_profile_name
  }

  # Configuring network interface with security groups and public IP assignment:
  network_interfaces {
    security_groups             = var.ec2_sg_ids
    associate_public_ip_address = true
  }

  # Adding user data script to bootstrap the instance (installing Apache, serving page):
  user_data = filebase64("${path.module}/userdata.sh")

  # Tagging instances launched with this template for identification:
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.name_prefix}-web-instance"
    }
  }
}