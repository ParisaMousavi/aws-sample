variable "name" {
  type = string
}

variable "tags" {
  default = {}
  type    = map(string)
}

variable "mfa_configuration" {
  type    = string
  default = null
}

variable "invite_message_template" {
  type = object({
    email_subject          = string,
    email_message_content = string,
    sms_message            = string
  })
}

variable "sms_configuration" {
  type = object({
    external_id         = string,
    sns_caller_role_arn = string
  })
  default = null
}

variable "schemas" {
  type = map(object({
    name                     = string,
    attribute_data_type      = string,
    developer_only_attribute = bool,
    mutable                  = bool,
    required                 = bool,
    string_attribute_constraints = object({
      min_length = number,
      max_length = number
    })
  }))
  default = null
}

variable "user_pool_domain_name" {
  type = string
}

variable "groups" {
  type = map(object({
    name = string
    description = string
  }))
  default = { }
}
