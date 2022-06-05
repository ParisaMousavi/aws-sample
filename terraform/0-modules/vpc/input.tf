variable "name" {
  type = string
}

variable "tags" {
  default = {}
  type    = map(string)
}

variable "with_internet_gateway" {
  type    = bool
  default = true
}

variable "cidr_block" {
  type = string
}

variable "private_subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))

}

variable "public_subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}