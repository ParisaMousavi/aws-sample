module "cognito_images_name" {
  source            = "../../0-modules/0-tf-name/s3"
  projectname       = var.projectname
  environment       = var.environment
  perfix            = "cognito-image"
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

data "template_file" "invitation_email" {
  template = file("${path.module}/template/invitation_message.html")
  vars = {
    image_bucket_regional_domain_name = module.cognito_images.bucket_regional_domain_name
  }
}

module "cognito_userpool_name" {
  source            = "../../0-modules/0-tf-name/cognito-userpool"
  projectname       = var.projectname
  environment       = var.environment
  perfix            = "a"
  region_short_name = var.region_short_name
}

module "cognito_userpool_domain" {
  source            = "../../0-modules/0-tf-name/cognito-userpool-domain"
  projectname       = var.projectname
  environment       = var.environment
  perfix            = "a"
  region_short_name = var.region_short_name
  domainname        = var.domainname
}

module "cognito_userpool" {
  source = "../../0-modules/cognito-userpool"
  depends_on = [
    module.cognito_images
  ]
  name              = module.cognito_userpool_name.default
  mfa_configuration = "OFF"
  sms_configuration = null
  invite_message_template = {
    email_subject         = "Your invitation to MY Application"
    email_message_content = data.template_file.invitation_email.rendered
    sms_message           = "Your username is {username} and temporary password is {####}."
  }
  schemas = {
    "family_name" = {
      name                     = "family_name"
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      required                 = true
      string_attribute_constraints = {
        min_length = 1
        max_length = 30
      }
    },
    "name" = {
      name                     = "name"
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      required                 = true
      string_attribute_constraints = {
        min_length = 4
        max_length = 20
      }
    }
  }
  user_pool_domain_name = module.cognito_userpool_domain.default
  groups = {
    "Mygroup" = {
      name        = "Computacentergroup"
      description = "Mygroup description."
    },
    "Othergroup" = {
      name        = "Ciscogroup"
      description = "Othergroup description."
    },
    "Admingroup" = {
      name        = "Admingroup"
      description = "Admingroup description."
    }
  }
  tags = {
    Name        = module.cognito_userpool_name.default
    Environment = var.environment
    Project     = var.projectname
    CostCenter  = var.costcenter
  }
}

# module "cognito_mfa_fcom_app" {
#   source        = "../../modules/cognito-api"
#   name          = "${lower(var.projectname)}-${lower(var.environment)}-app-${lower(var.region)}"
#   userpool_id   = module.cognito_mfa.userpool_id
#   callback_urls = ["https://${lower(var.environment)}.${lower(var.domainname)}/"]
# }
