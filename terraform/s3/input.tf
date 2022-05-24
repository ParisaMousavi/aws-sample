
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
  default = "aws-sample"
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
  default = "dev"
}

variable "costcenter" {
  type    = string
  default = "ABC000CBA"
}

variable "region" {
  type    = string
  default = "EUC1"
}