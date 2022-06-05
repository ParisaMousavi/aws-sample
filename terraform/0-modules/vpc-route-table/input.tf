variable "default_route_table_id" {
  type = string
}

variable "tags" {
  default = {}
  type    = map(string)
}