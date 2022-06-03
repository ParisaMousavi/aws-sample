variable "name" {
  type = string
}

variable "acl" {
  type = string
}

variable "policy_content" {
  type    = string
  default = "null"
}

variable "versioning" {
  type = bool
}

variable "tags" {
  default = {}
  type    = map(string)
}