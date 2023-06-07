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
module "docdb" {
  for_each = var.docdb
  source   = "./vendor/modules/docdb"
  engine   = each.value.engine
  name     = each.key
  env      = var.env
  subnets  = flatten([for i, j in module.vpc : j.private_subnets["database"]["subnets"][*].id])
}

#output "app_subnets" {
#  value = [for i,j in module.vpc : j.private_subnets["app"]["subnets"][*].id]
#}
module "rds" {
  for_each             = var.rds
  name                 = each.key
  source               = "./vendor/modules/rds"
  subnets              = flatten([for i, j in module.vpc : j.private_subnets["database"]["subnets"][*].id])
  allocated_storage    = each.value.allocated_storage
  engine               = each.value.engine
  engine_version       = each.value.engine_version
  instance_class       = each.value.instance_class

  skip_final_snapshot  = each.value.skip_final_snapshot
  env                  = var.env
}

module "elasticache" {
  for_each             = var.elasticache
  name                 = each.key
  env                  = var.env
  subnets              = flatten([for i, j in module.vpc : j.private_subnets["database"]["subnets"][*].id])
  source               = "./vendor/modules/elasticache"
  cluster_id           = each.value.cluster_id
  engine               = each.value.engine
  node_type            = each.value.node_type
  num_cache_nodes      = each.value.num_cache_nodes
  #parameter_group_name = each.value.parameter_group_name
  engine_version       = each.value.engine_version
  #port                 = each.value.port
}

module "rabbitmq" {
  source = "./vendor/modules/rabbitmq"
  for_each = var.rabbitmq
  env= var.env
  subnets = flatten([for i, j in module.vpc : j.private_subnets["database"]["subnets"][*].id])
  name=each.key
  instance_type = each.value.instance_type

}

module "app" {
  source = "./vendor/modules/app-setup"
  env= var.env
  subnets = flatten([for i, j in module.vpc : j.private_subnets["app"]["subnets"][*].id])
  instance_type = each.value.instance_type
  for_each =  var.apps
  name= each.key
  max_size = each.value.max_size
  min_size = each.value.min_size
#  vpc_id   = element([for i,j in module.vpc: j.vpc_id],0)
  BASTION_NODE = var.BASTION_NODE
}