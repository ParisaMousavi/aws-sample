module "cognito_images_name" {
  source            = "../../0-modules/0-tf-name/s3"
  projectname       = var.projectname
  environment       = var.environment
  perfix            = var.perfix
  region_short_name = var.region_short_name
}

data "template_file" "cognito_images_s3_policy" {
  template = file("${path.module}/policies/s3-readonly.json")
  vars = {
    s3_arn = "arn:aws:s3:::${module.cognito_images_name.default}"
  }
}

module "cognito_images" {
  source         = "../../0-modules/s3"
  name           = module.cognito_images_name.default
  acl            = "public-read"
  policy_content = data.template_file.cognito_images_s3_policy.rendered
  versioning     = false
  tags = {
    Name        = module.cognito_images_name.default
    Environment = var.environment
    Project     = var.projectname
    CostCenter  = var.costcenter
  }
}


output "name" {
  value = module.cognito_images
}