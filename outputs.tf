output "vpc" {
  value = module.vpc.vpc
}

output "aws_route_table" {
  value = module.vpc.aws_route_table
}
