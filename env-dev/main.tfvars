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
  vpc_id           = "vpc-035fa532ad2dcf0c8"
  route_table      = "rtb-0f854481b639897d9"
  default_vpc_cidr = "172.31.0.0/16"
}

docdb = {
  db1 = {
    engine              = "docdb"
    skip_final_snapshot = true
    nodes               = {
      one = {
        instance_class = "db.t3.medium"
      }
    }
  }
}

rds = {
  db1 = {
    allocated_storage   = 10
    engine              = "aurora-mysql"
    engine_version      = "5.7.mysql_aurora.2.11.2"
    instance_class      = "db.t3.micro"
    skip_final_snapshot = true
    nodes               = {
      one = {
        instance_class = "db.t3.small"
      }
    }
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

rabbitmq = {
  mq1 = {
    instance_type = "t3.micro"
  }
}

apps = {
  frontend = {
    instance_type       = "t3.micro"
    max_size            = 1
    min_size            = 1
    app_port_no         = 80
    type                = "frontend"
    lb_listner_priority = 0
    public_dns_name     = "dev"
  }
  cart = {
    instance_type       = "t3.micro"
    max_size            = 1
    min_size            = 1
    app_port_no         = 8080
    lb_listner_priority = 100
    type                = "backend"
  }
  catalogue = {
    instance_type       = "t3.micro"
    max_size            = 1
    min_size            = 1
    app_port_no         = 8080
    lb_listner_priority = 101
    type                = "backend"
  }
  user = {
    instance_type       = "t3.micro"
    max_size            = 1
    min_size            = 1
    app_port_no         = 8080
    lb_listner_priority = 102
    type                = "backend"
  }
  shipping = {
    instance_type       = "t3.micro"
    max_size            = 1
    min_size            = 1
    app_port_no         = 8080
    lb_listner_priority = 103
    type                = "backend"
  }
  payment = {
    instance_type       = "t3.micro"
    max_size            = 1
    min_size            = 1
    app_port_no         = 8080
    lb_listner_priority = 104
    type                = "backend"
  }


}

BASTION_NODE    = "172.31.86.61/32"
private_zone_id = "Z08699481VHN1W3OT4FY3"
public_zone_id  = "Z008607032EXFLAVFBUCE"
PROMETHEUS_NODE = "172.31.24.84/32"

alb = {
  public = {
    internal = false
  }
  private = {
    internal = true
  }
}

ACM_ARN = "arn:aws:acm:us-east-1:542712333710:certificate/d8e94121-7b28-42b7-873c-a7c071b1bd80"


