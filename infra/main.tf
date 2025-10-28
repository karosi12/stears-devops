provider "aws" {
  region     = var.region # Change this to your desired region
  access_key = var.access_key
  secret_key = var.secret_key
}

terraform {
  backend "s3" {
    bucket  = "terraform-state-demo-14" # Change this to your S3 bucket name
    key     = "terraform.tfstate"
    region  = "us-east-2"
    encrypt = true
  }
}

module "vpc" {
  source               = "./modules/vpc"
  vpc_name             = var.vpc_name
  cidr_block           = "10.0.0.0/16"
  public_subnet_cidr1  = "10.0.1.0/24"
  public_subnet_cidr2  = "10.0.4.0/24"
  private_subnet_cidr1 = "10.0.2.0/24"
  private_subnet_cidr2 = "10.0.3.0/24"
  availability_zone1   = "us-east-2a"
  availability_zone2   = "us-east-2b"
  availability_zone3   = "us-east-2c"
  broker_name          = var.broker_name
  environment          = var.environment
}

module "ecs" {
  source          = "./modules/ecs"
  vpc_id          = module.vpc.vpc_id
  private_subnet1 = module.vpc.private_subnet1
  private_subnet2 = module.vpc.private_subnet2
  public_subnet1  = module.vpc.public_subnet1
  public_subnet2  = module.vpc.public_subnet2
  depends_on      = [module.vpc]
  environment     = var.environment
}

module "rds" {
  source                = "./modules/rds"
  vpc_id                = module.vpc.vpc_id
  vpc_cidr              = "10.0.0.0/16"
  private_subnets       = [module.vpc.private_subnet1, module.vpc.private_subnet2] #module.vpc.private_subnets
  cluster_identifier    = var.cluster_identifier
  master_username       = var.master_username
  master_password       = var.master_password
  database_name         = var.database_name
  proxy_name            = var.proxy_name
  rds_proxy_secret_name = var.rds_proxy_secret_name
  environment           = var.environment
}

module "cache" {
  source          = "./modules/elasticache"
  vpc_id          = module.vpc.vpc_id
  private_subnets = [module.vpc.private_subnet1, module.vpc.private_subnet2]
  vpc_cidr        = module.vpc.vpc_cidr
  cluster_id      = "${var.cluster_id}-cache"
  depends_on      = [module.vpc]
  environment     = var.environment
}

module "message_broker" {
  source             = "./modules/message_broker"
  subnet_ids         = [module.vpc.private_subnet1, module.vpc.private_subnet2]
  broker_name        = "${var.vpc_name}-broker"
  broker_nodes       = var.broker_nodes
  host_instance_type = var.host_instance_type
  engine_version     = var.engine_version
  vpc_id             = module.vpc.vpc_id
  ecs_tasks_sg_id    = module.ecs.ecs_security_group_id
  environment        = var.environment
}

