module "vpc" {
  source   = "./vendor/modules/vpc"
  vpc      = var.vpc
  env      = var.env
  management_vpc = var.management_vpc
}

## here module will take care how to iterate and this way main code i am keeping minimal and will enhance module with other things


#module "docdb" {
#  source   = "./vendor/modules/docdb"
#  docdb      = var.docdb
#  env      = var.env
#}

output "app_private_subnets" {
  value = local.private_subnets[*].id
}