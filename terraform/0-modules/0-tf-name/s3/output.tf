output "default" {
  value = format("%s-s3", join("-", compact([lower(var.projectname), lower(var.environment), lower(var.region_short_name), lower(var.perfix)])))
}