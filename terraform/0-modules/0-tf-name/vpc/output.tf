output "default" {
  value = format("%s-vpc", join("-", compact([lower(var.projectname), lower(var.environment), lower(var.region_short_name), lower(var.perfix)])))
}