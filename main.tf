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
  private_zone_id           = var.private_zone_id
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
  for_each            = var.docdb
  source              = "./vendor/modules/docdb"
  engine              = each.value.engine
  name                = each.key
  env                 = var.env
  subnets             = flatten([for i, j in module.vpc : j.private_subnets["database"]["subnets"][*].id])
  nodes               = each.value.nodes
  skip_final_snapshot = each.value.skip_final_snapshot
  vpc_id              = element([for i, j in module.vpc : j.vpc_id], 0)
  BASTION_NODE        = var.BASTION_NODE
  vpc_cidr            = element([for i, j in module.vpc : j.vpc_cidr], 0)
}

#output "app_subnets" {
#  value = [for i,j in module.vpc : j.private_subnets["app"]["subnets"][*].id]
#}
module "rds" {
  for_each            = var.rds
  name                = each.key
  source              = "./vendor/modules/rds"
  subnets             = flatten([for i, j in module.vpc : j.private_subnets["database"]["subnets"][*].id])
  allocated_storage   = each.value.allocated_storage
  engine              = each.value.engine
  engine_version      = each.value.engine_version
  instance_class      = each.value.instance_class
  skip_final_snapshot = each.value.skip_final_snapshot
  env                 = var.env
  vpc_id              = element([for i, j in module.vpc : j.vpc_id], 0)
  BASTION_NODE        = var.BASTION_NODE
  vpc_cidr            = element([for i, j in module.vpc : j.vpc_cidr], 0)
  nodes               = each.value.nodes
}

module "elasticache" {
  for_each        = var.elasticache
  name            = each.key
  env             = var.env
  subnets         = flatten([for i, j in module.vpc : j.private_subnets["database"]["subnets"][*].id])
  source          = "./vendor/modules/elasticache"
  cluster_id      = each.value.cluster_id
  engine          = each.value.engine
  node_type       = each.value.node_type
  num_cache_nodes = each.value.num_cache_nodes
  #parameter_group_name = each.value.parameter_group_name
  engine_version  = each.value.engine_version
  #port                 = each.value.port
  vpc_id          = element([for i, j in module.vpc : j.vpc_id], 0)
  vpc_cidr        = element([for i, j in module.vpc : j.vpc_cidr], 0)
}

module "rabbitmq" {
  source          = "./vendor/modules/rabbitmq"
  for_each        = var.rabbitmq
  env             = var.env
  subnets         = flatten([for i, j in module.vpc : j.private_subnets["database"]["subnets"][*].id])
  name            = each.key
  instance_type   = each.value.instance_type
  private_zone_id = var.private_zone_id
  BASTION_NODE    = var.BASTION_NODE
  vpc_id          = element([for i, j in module.vpc : j.vpc_id], 0)
  vpc_cidr        = element([for i, j in module.vpc : j.vpc_cidr], 0)
}

module "app" {
  depends_on = [module.vpc, module.rabbitmq, module.elasticache, module.docdb, module.alb, module.rds]
  source     = "./vendor/modules/app-setup"
  env        = var.env
  subnets    = each.key == "frontend" ? flatten([
    for i, j in module.vpc :j.private_subnets["frontend"]["subnets"][*].id
  ]) : flatten([for i, j in module.vpc : j.private_subnets["app"]["subnets"][*].id])
  instance_type       = each.value.instance_type
  for_each            = var.apps
  name                = each.key
  max_size            = each.value.max_size
  min_size            = each.value.min_size
  lb_listner_priority = each.value.lb_listner_priority
  type                = each.value.type
  vpc_id              = element([for i, j in module.vpc : j.vpc_id], 0)
  BASTION_NODE        = var.BASTION_NODE
  app_port_no         = each.value.app_port_no
  PROMETHEUS_NODE     = var.PROMETHEUS_NODE
  vpc_cidr            = element([for i, j in module.vpc : j.vpc_cidr], 0)
  alb                 = module.alb
  private_zone_id     = var.private_zone_id
  public_zone_id      = var.public_zone_id
  public_dns_name     = try(each.value.public_dns_name, null)
  ACM_ARN             = var.ACM_ARN
}


module "alb" {
  for_each = local.merged_alb
  source   = "./vendor/modules/alb"
  env      = var.env
  subnets  = each.value.subnets
  name     = each.key
  vpc_id   = element([for i, j in module.vpc : j.vpc_id], 0)
  vpc_cidr = element([for i, j in module.vpc : j.vpc_cidr], 0)
  internal = each.value.internal

}


