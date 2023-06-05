locals {
  private_subnets = {for k, v in module.vpc :k=> v.private_subnets}
}