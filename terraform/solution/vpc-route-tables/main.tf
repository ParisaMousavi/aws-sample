# module "default_route_table" {
#   source = "../../0-modules/default-route-table"
#   depends_on = [
#     module.vpc
#   ]
#   vpc_id = module.vpc.vpc_id
#   routes = {
#     "internet_access" = {
#       cidr_block = "0.0.0.0/0",
#       gateway_id = module.vpc.internet_gateway_id
#     }
#   }                                      // for internet access
#   subnet_ids = module.vpc.public_subnets
#   subnet_tag_names = keys(local.public_subnets[lower(var.environment)])
#   tags = {
#     Name        = module.default_route_table_name.default
#     Environment = var.environment
#     Project     = var.projectname
#     CostCenter  = var.costcenter
#   }
# }

# module "route_table_name" {
#   source            = "../../0-modules/0-tf-name/route-table"
#   projectname       = var.projectname
#   environment       = var.environment
#   perfix            = "private"
#   region_short_name = var.region_short_name
# }

# module "private_route_table" {
#   source = "../../0-modules/route-table"
#   depends_on = [
#     module.vpc
#   ]
#   vpc_id                 = module.vpc.vpc_id
#   routes                 = {} // for later if NAT is needed
#   subnet_ids             = module.vpc.private_subnets // for later if NAT is needed
#   tags = {
#     Name        = module.route_table_name.default
#     Environment = var.environment
#     Project     = var.projectname
#     CostCenter  = var.costcenter
#   }
# }
