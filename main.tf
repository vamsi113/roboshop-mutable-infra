module "vpc" {
  source = "github.com/vamsi113/tf-module-vpc.git?ref=${var.ver}"
}

variable "ver" {}