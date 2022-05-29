
#----------------------------------------------------
# Specific variables
#----------------------------------------------------
variable "vpc_cidr_block" {
  type = map(any)
  default = {
    "acc"  = "10.102.0.0/16",
    "dev"  = "10.101.0.0/16",
    "prod" = "10.100.0.0/16"
  }
}

variable "subnet_cidr_block" {
  type = map(any)
  default = {
    "acc"  = { private = "10.102.1.0/24", public_a = "10.102.2.0/24", public_b = "10.102.3.0/24" },
    "dev"  = { private = "10.101.1.0/24", public_a = "10.101.2.0/24", public_b = "10.101.3.0/24" },
    "prod" = { private = "10.100.1.0/24", public_a = "10.100.2.0/24", public_b = "10.100.3.0/24" }
  }
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