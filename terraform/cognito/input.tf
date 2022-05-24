#----------------------------------------------------
# Specific variables
#----------------------------------------------------
variable "domainname" {
  type    = string
  default = "multi-cloud-solutions"
}

#----------------------------------------------------
# General variable
#----------------------------------------------------
variable "projectname" {
  type    = string
  default = "FCOM"
}

variable "environment" {
  type    = string
  default = "ACC"
}

variable "imagenames" {
  type    = string
  default = "opportunity,customer,service,appsetting"
}

variable "tag" {
  default = "DEV"
}

variable "costcenter" {
  type    = string
  default = "ABC000CBA"
}

variable "region" {
  type    = string
  default = "EUC1"
}

variable "terraform_remote_state_bucket" {
  type    = string
  default = "terraform-aws-sample-dev-euc1"
}


