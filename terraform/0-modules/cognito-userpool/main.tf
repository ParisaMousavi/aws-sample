resource "aws_cognito_user_pool" "this" {
  name                       = var.name
  auto_verified_attributes   = var.mfa_configuration != null ? ["email"] : []
  mfa_configuration          = var.mfa_configuration != "OFF" ? var.mfa_configuration : "OFF"
  sms_authentication_message = var.mfa_configuration != "OFF" ? "Cisco Fcom : Your verification code is {####}" : null


  dynamic "sms_configuration" {
    for_each = var.mfa_configuration != "OFF" ? [1] : []
    content {
      external_id    = var.sms_configuration.external_id
      sns_caller_arn = var.sms_configuration.sns_caller_role_arn
    }

  }

  # for the App MFA 
  # software_token_mfa_configuration {
  #   enabled = true
  # }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  username_configuration {
    case_sensitive = false
  }

  password_policy {
    minimum_length                   = 8
    require_lowercase                = true
    require_numbers                  = true
    require_uppercase                = true
    require_symbols                  = true
    temporary_password_validity_days = 7
  }

  admin_create_user_config {
    allow_admin_create_user_only = true
    invite_message_template {
      email_subject = var.invite_message_template.email_subject
      email_message = var.invite_message_template.email_message_content
      sms_message   = var.invite_message_template.sms_message
    }
  }


  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  // Standard attributes
  // https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-attributes.html#cognito-user-pools-standard-attributes
  dynamic "schema" {
    for_each = var.schemas
    content {
      name                     = schema.value.name != null ? schema.value.name : null
      attribute_data_type      = schema.value.attribute_data_type != null ? schema.value.attribute_data_type : null
      developer_only_attribute = schema.value.developer_only_attribute != null ? schema.value.developer_only_attribute : null
      mutable                  = schema.value.mutable != null ? schema.value.mutable : null
      required                 = schema.value.required != null ? schema.value.required : null
      string_attribute_constraints {
        min_length = schema.value.string_attribute_constraints.min_length != null ? schema.value.string_attribute_constraints.min_length : null
        max_length = schema.value.string_attribute_constraints.max_length != null ? schema.value.string_attribute_constraints.max_length : null
      }
    }
  }

  tags = var.tags
}

resource "aws_cognito_user_pool_domain" "this" {
  domain       = var.user_pool_domain_name
  user_pool_id = aws_cognito_user_pool.this.id
}


resource "aws_cognito_user_group" "this" {
  for_each     = var.groups
  name         = each.value.name
  description  = each.value.description
  user_pool_id = aws_cognito_user_pool.this.id
}
