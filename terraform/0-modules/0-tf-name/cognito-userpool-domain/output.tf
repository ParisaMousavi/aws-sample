output "default" {
  value = format("${var.domainname}-%s", join("-", compact([lower(var.projectname), lower(var.environment), lower(var.region_short_name), lower(var.perfix)])))
}