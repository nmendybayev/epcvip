# Contains Terraform modules:  

module "vpc" {
  source              = "./modules/vpc"
  name_prefix         = var.name_prefix
  vpc_cidr            = var.vpc_cidr
  public_subnet_count = var.public_subnet_count
}

module "sg" {
  source      = "./modules/sg"
  name_prefix = var.name_prefix
  vpc_id      = module.vpc.vpc_id
  http_port   = var.http_port
}

module "iam" {
  source      = "./modules/iam"
  name_prefix = var.name_prefix
}

module "launch_template" {
  source                    = "./modules/launch_template"
  name_prefix               = var.name_prefix
  ami_id                    = var.ami_id
  instance_type             = var.instance_type
  ec2_sg_ids                = [module.sg.ec2_sg_id]
  ec2_instance_profile_name = module.iam.ec2_instance_profile_name
}

module "alb" {
  source            = "./modules/alb"
  name_prefix       = var.name_prefix
  http_port         = var.http_port
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnets
  alb_sg_ids        = [module.sg.alb_sg_id]
}

module "asg" {
  source                        = "./modules/asg"
  name_prefix                   = var.name_prefix
  asg_max_size                  = var.asg_max_size
  asg_min_size                  = var.asg_min_size
  asg_desired_capacity          = var.asg_desired_capacity
  asg_health_check_grace_period = var.asg_health_check_grace_period
  launch_template_id            = module.launch_template.launch_template_id
  public_subnet_ids             = module.vpc.public_subnets
  target_group_arns             = [module.alb.target_group_arn]
}

module "alarms" {
  source               = "./modules/alarms"
  name_prefix          = var.name_prefix
  scale_out_adjustment = var.scale_out_adjustment
  scale_in_adjustment  = var.scale_in_adjustment
  scale_cooldown       = var.scale_cooldown
  metric_period        = var.metric_period
  cpu_high_threshold   = var.cpu_high_threshold
  cpu_low_threshold    = var.cpu_low_threshold
  asg_name             = module.asg.asg_name
}