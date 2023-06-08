
##output "subnets" {
#  value = module.vpc.subnets
#}


#output "route_tables" {
#  value = module.vpc.route_tables
#}

##updated modules

#output "vpc" {
#  value = module.vpc
#}

#output "merr" {
#  value = local.merged_alb
##}

output "alb" {
  value = module.alb
}