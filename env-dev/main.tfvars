env = "dev"
vpc = {
  vpc1 = {
    cidr_block            = "10.0.0.0/16"
    additional_cidr_block = []
    private_subnets       = {
      frontend = {
        cidr_block = ["10.0.0.0/24", "10.0.1.0/24"]
        name       = "frontend"
        attach_to  = "ngw"
      }
      database = {
        cidr_block = ["10.0.2.0/24", "10.0.3.0/24"]
        name       = "database"
        attach_to  = "ngw"
      }
      app = {
        cidr_block = ["10.0.4.0/24", "10.0.5.0/24"]
        name       = "app"
        attach_to  = "ngw"
      }
    }
    public_subnets = {
      public = {
        cidr_block = ["10.0.255.0/24", "10.0.254.0/24"]
        name       = "public"
        attach_to  = "igw"
      }
    }
    subnet_availability_zones = ["us-east-1a", "us-east-1b"]
  }
  #  vpc2 = {
  #    cidr_block = "10.1.0.0/16"
  #    additional_cidr_block = []
  #    private_subnets = {
  #      frontend = {
  #        cidr_block = ["10.1.0.0/24", "10.1.1.0/24"]
  #        name       = "frontend"
  #        attach_to  = "ngw"
  #      }
  #      database = {
  #        cidr_block = ["10.1.2.0/24", "10.1.3.0/24"]
  #        name       = "database"
  #        attach_to  = "ngw"
  #      }
  #      app = {
  #        cidr_block = ["10.1.4.0/24", "10.1.5.0/24"]
  #        name       = "app"
  #        attach_to  = "ngw"
  #      }
  #    }
  #    public_subnets = {
  #      public  = {
  #        cidr_block = ["10.1.255.0/24", "10.1.254.0/24"]
  #        name       = "public"
  #        attach_to  = "igw"
  #      }
  #    }
  #    subnet_availability_zones = ["us-east-1a", "us-east-1b"]
  #  }
}

management_vpc = {
  vpc_id           = "vpc-0035013d8f7f13f35"
  route_table      = "rtb-0f3763bf2c221c7b2"
  default_vpc_cidr = "172.31.0.0/16"
}

docdb = {
  db1 = {
    engine = "docdb"
  }
}

rds = {
  db1 = {
    allocated_storage    = 10
    engine               = "aurora-mysql"
    engine_version       = "5.7.mysql_aurora.2.11.2"
    instance_class       = "db.t3.micro"
    skip_final_snapshot  = true
  }

}

elasticache = {
  ec1 = {
    cluster_id      = "elasticache"
    engine          = "redis"
    node_type       = "cache.t3.micro"
    num_cache_nodes = 1
    engine_version  = "6.2"
    #port                 = 6379
  }
}

rabbitmq ={
  mq1 ={
    instance_type ="t3.micro"
  }
}

apps = {
  cart ={
    instance_type = "t3.micro"
    max_size           = 1
    min_size           = 1
  }
}

BASTION_NODE = "172.31.5.124/32"