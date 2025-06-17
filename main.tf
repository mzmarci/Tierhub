module "Bastion" {
  source                 = "./module/ec2"
  ec2_ami                = var.ec2_ami
  ec2_instance_type      = var.ec2_instance_type1 == "dev" ? "t2.micro" : "t2.small"
  ec2_key_name           = var.ec2_key_name == "prod" ? "test100" : "assign1"
  vpc_security_group_ids = [module.security_group.web_security_group_id]
  public_subnets_id      = module.mainvpc.public_subnets_id[*]
  user_data              = file("npm.sh")


}

module "mainvpc" {
  source               = "./module/network"
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  vpc_cidr             = var.vpc_cidr

}

module "security_group" {
  source = "./module/securitygroup"
  vpc_id = module.mainvpc.vpc_id
}

module "load_balancer" {
  source                    = "./module/alb"
  frontend_target_group_arn = module.load_balancer.frontend_target_group_arn
  vpc_id                    = module.mainvpc.vpc_id
  public_subnets_id         = module.mainvpc.public_subnets_id
  private_subnets_id        = module.mainvpc.private_subnets_id
  alb_security_group_id     = [module.security_group.alb_security_group_id]
  ami_id                    = var.ec2_ami
  instance_type             = var.ec2_instance_type
}