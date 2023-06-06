#module "vpc" {
#  source   = "./vendor/modules/vpc"
#  vpc      = var.vpc
#  env      = var.env
#  management_vpc = var.management_vpc
#}

module "vpc" {
  for_each                  = var.vpc
  source                    = "./vendor/modules/vpc"
  cidr_block                = each.value.cidr_block
  additional_cidr_block     = each.value.additional_cidr_block
  private_subnets           = each.value.private_subnets
  public_subnets            = each.value.public_subnets
  subnet_availability_zones = each.value.subnet_availability_zones
  env                       = var.env
  management_vpc            = var.management_vpc
}


## here module will take care how to iterate and this way main code i am keeping minimal and will enhance module with other things
#
#
#module "docdb" {
#  source   = "./vendor/modules/docdb"
#  docdb      = var.docdb
#  env      = var.env
#  subnets  = local.database_private_subnets[*].id
#}
#
#module "rds" {
#  source   = "./vendor/modules/rds"
#  rds      = var.rds
#  env      = var.env
#  subnets  = local.database_private_subnets[*].id
#}
#
