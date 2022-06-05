module "vpc_name" {
  source            = "../../0-modules/0-tf-name/vpc"
  projectname       = var.projectname
  environment       = var.environment
  perfix            = "cognito-image"
  region_short_name = var.region_short_name
}