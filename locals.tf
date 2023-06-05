locals {
  private_subnets =lookup(lookup({for k, v in module.vpc.private_subnets : "subnets" => v.subnets}, "subnets", null),"app", null)
}