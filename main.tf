module "vpc" {
  source   = "./vendor/modules/vpc"
  vpc      = var.vpc
  env      = var.env
}

## here module will take care how to iterate and this way main code i am keeping minimal and will enhance module with other things