variable "tags" {
  default = {}
  type    = map(string)
}

variable "vpc_id" {
  type = string
}

variable "routes" {
  type = map(object({
    cidr_block = string
    gateway_id = string
  }))
}

variable "subnet_ids" {
  type = list(string)
}
