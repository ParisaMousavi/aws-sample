output "default" {
  value = format("%s-cgup", join("-", compact([lower(var.projectname), lower(var.environment), lower(var.region_short_name), lower(var.perfix)])))
}