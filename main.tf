module "vpc" {
  source = "./modules/vpc"
  providers = {
    aws = aws.east
  }
}

module "tls" {
  source    = "./modules/tls"
  key_name  = "aws"
  file_path = "${path.module}/aws.pem"
}

module "security_groups" {
  source                        = "./modules/security_groups"
  vpc_id                        = module.vpc.vpc_id
  inbound_ports                 = var.inbound_ports
  create_alb_ref_security_group = false
  providers = {
    aws = aws.east
  }
}

module "secrets" {
  source = "./modules/secrets"
  providers = {
    aws = aws.east
  }
}

module "instance" {
  source         = "./modules/instance"
  web_sg         = module.security_groups.web_security_group
  public_subnets = module.vpc.public_subnets
  secret_data    = module.secrets.secret_data
  providers = {
    aws = aws.east
  }
}