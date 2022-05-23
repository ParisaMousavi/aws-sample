#----------------------------------------------------
# Specific variables
#----------------------------------------------------
variable "domainname" {
  type    = string
  default = "cc-fco.de"
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