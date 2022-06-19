
locals {
  vpc_cidr_block = {
    "acc"  = "10.102.0.0/16",
    "dev"  = "10.101.0.0/16",
    "prod" = "10.100.0.0/16"
  }

  private_subnets = {
    "acc" = {
      "${module.subnet_private_name.default}-1" = {
        availability_zone = "eu-central-1a"
        cidr_block        = "10.102.1.0/24"
      },
      "${module.subnet_private_name.default}-2" = {
        availability_zone = "eu-central-1b"
        cidr_block        = "10.102.2.0/24"
      }
    },
    "dev" = {
      "${module.subnet_private_name.default}-1" = {
        availability_zone = "eu-central-1a"
        cidr_block        = "10.101.1.0/24"
      },
      "${module.subnet_private_name.default}-2" = {
        availability_zone = "eu-central-1b"
        cidr_block        = "10.101.2.0/24"
      }
    },
    "prod" = {
      "${module.subnet_private_name.default}-1" = {
        availability_zone = "eu-central-1a"
        cidr_block        = "10.100.1.0/24"
      },
      "${module.subnet_private_name.default}-2" = {
        availability_zone = "eu-central-1b"
        cidr_block        = "10.100.2.0/24"
      }
    }
  }

  public_subnets = {
    "acc" = {
      "${module.subnet_public_name.default}-1" = {
        availability_zone = "eu-central-1a"
        cidr_block        = "10.102.101.0/24"
      },
      "${module.subnet_public_name.default}-2" = {
        availability_zone = "eu-central-1b"
        cidr_block        = "10.102.102.0/24"
      }
    },
    "dev" = {
      "${module.subnet_public_name.default}-1" = {
        availability_zone = "eu-central-1a"
        cidr_block        = "10.101.101.0/24"
      },
      "${module.subnet_public_name.default}-2" = {
        availability_zone = "eu-central-1b"
        cidr_block        = "10.101.102.0/24"
      }
    },
    "prod" = {
      "${module.subnet_public_name.default}-1" = {
        availability_zone = "eu-central-1a"
        cidr_block        = "10.100.101.0/24"
      },
      "${module.subnet_public_name.default}-2" = {
        availability_zone = "eu-central-1b"
        cidr_block        = "10.100.102.0/24"
      }
    }
  }

}

module "vpc_name" {
  source            = "../../0-modules/0-tf-name/vpc"
  projectname       = var.projectname
  environment       = var.environment
  perfix            = ""
  region_short_name = var.region_short_name
}

module "subnet_private_name" {
  source            = "../../0-modules/0-tf-name/subnet"
  projectname       = var.projectname
  environment       = var.environment
  perfix            = "private"
  region_short_name = var.region_short_name
}

module "subnet_public_name" {
  source            = "../../0-modules/0-tf-name/subnet"
  projectname       = var.projectname
  environment       = var.environment
  perfix            = "public"
  region_short_name = var.region_short_name
}

module "vpc" {
  source                = "../../0-modules/vpc"
  name                  = module.vpc_name.default
  with_internet_gateway = true
  cidr_block            = local.vpc_cidr_block[lower(var.environment)]
  private_subnets       = local.private_subnets[lower(var.environment)]
  public_subnets        = local.public_subnets[lower(var.environment)]
  tags = {
    Name        = module.vpc_name.default
    Environment = var.environment
    Project     = var.projectname
    CostCenter  = var.costcenter
  }
}

output "xyz" {
  value = module.vpc
}

module "default_route_table_name" {
  source = "../../0-modules/0-tf-name/route-table"
  depends_on = [
    module.vpc
  ]
  projectname       = var.projectname
  environment       = var.environment
  perfix            = "default"
  region_short_name = var.region_short_name
}

output "aaa" {
  value = keys(local.public_subnets[lower(var.environment)])
}

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
