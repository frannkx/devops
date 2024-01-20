provider "aws" {
  region = "tu_region_de_aws"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.8.0"
  cidr = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

module "public_subnet" {
  source  = "./modules/subnets/public_subnet"
  vpc_id  = module.vpc.vpc_id
  cidr_block = "10.0.1.0/24"
}

module "private_app_subnet" {
  source  = "./modules/subnets/private_app_subnet"
  vpc_id  = module.vpc.vpc_id
  cidr_block = "10.0.2.0/24"
}
