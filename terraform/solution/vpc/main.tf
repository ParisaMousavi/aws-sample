module "vpc_name" {
  source            = "../../0-modules/0-tf-name/vpc"
  projectname       = var.projectname
  environment       = var.environment
  perfix            = "cognito-image"
  region_short_name = var.region_short_name
}

module "vpc" {
  source            = "../../0-modules/vpc"
  name       = module.vpc_name.default
  with_internet_gateway = true
    tags = {
    Name        = module.cognito_images_name.default
    Environment = var.environment
    Project     = var.projectname
    CostCenter  = var.costcenter
  }
}

