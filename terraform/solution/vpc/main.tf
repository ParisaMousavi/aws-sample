
locals {
  vpc_cidr_block = {
    "acc"  = "10.102.0.0/16",
    "dev"  = "10.101.0.0/16",
    "prod" = "10.100.0.0/16"
  }

  subnet_cidr_block = {
    "acc"  = { private = "10.102.1.0/24", public_a = "10.102.2.0/24", public_b = "10.102.3.0/24" },
    "dev"  = { private = "10.101.1.0/24", public_a = "10.101.2.0/24", public_b = "10.101.3.0/24" },
    "prod" = { private = "10.100.1.0/24", public_a = "10.100.2.0/24", public_b = "10.100.3.0/24" }
  }

}

module "vpc_name" {
  source            = "../../0-modules/0-tf-name/vpc"
  projectname       = var.projectname
  environment       = var.environment
  perfix            = ""
  region_short_name = var.region_short_name
}

module "vpc" {
  source                = "../../0-modules/vpc"
  name                  = module.vpc_name.default
  with_internet_gateway = true
  cidr_block = local.vpc_cidr_block[lower(var.environment)]
  tags = {
    Name        = module.vpc_name.default
    Environment = var.environment
    Project     = var.projectname
    CostCenter  = var.costcenter
  }
}

