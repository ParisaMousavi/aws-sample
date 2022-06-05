variable "name" {
  type = string
}

variable "tags" {
  default = {}
  type    = map(string)
}

variable "with_internet_gateway" {
    type = bool
    default = true
}

variable  "cidr_block" {
  type        = string
}
