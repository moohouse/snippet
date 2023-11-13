#common Tag
common_tags = {
    Company     = "Mooheadtown"
    Service     = "moo"
    Project     = "moo"
    Environment = "dev"
}

#VPC
vpc_create = [
  {
    index                = "moo_dev"
    type                 = "vpc"
    cidr_block           = "172.21.0.0/16"
    secondary_cidr_block = null
    instance_tenancy     = "default"
    enable_dns_hostnames = "true"
    enable_dns_support   = "true"
    enable_ipv6          = "false"
    aws_internet_gateway = true
  }
]

subnet_create = [
  {
    index                   = "sbn1"
    vpc_index               = "moo_dev"
    purpose                 = "bastion"
    type                    = "sbn"
    position                = "public"
    availability_zone       = "ap-northeast-2a"
    cidr_block              = "172.21.1.0/24"
    map_public_ip_on_launch = "true"
  },
  {
    index                   = "sbn2"
    vpc_index               = "moo_dev"
    purpose                 = "bastion"
    type                    = "sbn"
    position                = "public"
    availability_zone       = "ap-northeast-2c"
    cidr_block              = "172.21.129.0/24"
    map_public_ip_on_launch = "true"
  },
  {
    index                   = "sbn3"
    vpc_index               = "moo_dev"
    purpose                 = "dmz"
    type                    = "sbn"
    position                = "public"
    availability_zone       = "ap-northeast-2a"
    cidr_block              = "172.21.0.0/24"
    map_public_ip_on_launch = "true"
    custom_tags = {
      "kubernetes.io/role/elb" = "1"
    }
  },
  {
    index                   = "sbn4"
    vpc_index               = "moo_dev"
    purpose                 = "dmz"
    type                    = "sbn"
    position                = "public"
    availability_zone       = "ap-northeast-2c"
    cidr_block              = "172.21.128.0/24"
    map_public_ip_on_launch = "true"
    custom_tags = {
      "kubernetes.io/role/elb" = "1"
    }
  },
  {
    index                   = "sbn5"
    vpc_index               = "moo_dev"
    purpose                 = "eks"
    type                    = "sbn"
    position                = "private"
    availability_zone       = "ap-northeast-2a"
    cidr_block              = "172.21.32.0/19"
    map_public_ip_on_launch = "false"
    custom_tags = {
      "kubernetes.io/role/internal-elb" = "1"
    }
  },
  {
    index                   = "sbn6"
    vpc_index               = "moo_dev"
    purpose                 = "eks"
    type                    = "sbn"
    position                = "private"
    availability_zone       = "ap-northeast-2c"
    cidr_block              = "172.21.160.0/19"
    map_public_ip_on_launch = "false"
    custom_tags = {
      "kubernetes.io/role/internal-elb" = "1"
    }
  },
  {
    index                   = "sbn7"
    vpc_index               = "moo_dev"
    purpose                 = "db"
    type                    = "sbn"
    position                = "private"
    availability_zone       = "ap-northeast-2a"
    cidr_block              = "172.21.64.0/24"
    map_public_ip_on_launch = "false"
  },
  {
    index                   = "sbn8"
    vpc_index               = "moo_dev"
    purpose                 = "db"
    type                    = "sbn"
    position                = "private"
    availability_zone       = "ap-northeast-2c"
    cidr_block              = "172.21.192.0/24"
    map_public_ip_on_launch = "false"
  },
  {
    index                   = "sbn9"
    vpc_index               = "moo_dev"
    purpose                 = "mwaa"
    type                    = "sbn"
    position                = "private"
    availability_zone       = "ap-northeast-2a"
    cidr_block              = "172.21.65.0/24"
    map_public_ip_on_launch = "false"
  },
  {
    index                   = "sbn10"
    vpc_index               = "moo_dev"
    purpose                 = "mwaa"
    type                    = "sbn"
    position                = "private"
    availability_zone       = "ap-northeast-2c"
    cidr_block              = "172.21.193.0/24"
    map_public_ip_on_launch = "false"
  }
]

nat_create = [
  { index          = "sbn1-nat"
    type           = "nat"
    sub_index      = "sbn1"
    networkboudary = "pub"
  }
]

# endpoint
ep_interface_create = [
  { index           = "ec2"
    vpc_index       = "moo_dev"
    sub_index       = ["sbn5", "sbn6"]
    svc_name        = "com.amazonaws.ap-northeast-2.ec2"
    sg_index        = ["dev_vpce_pri"]
    pri_dns_enabled = true
    purpose         = "ec2"
    type            = "vpce"
  },
  { index           = "ecr-api"
    vpc_index       = "moo_dev"
    sub_index       = ["sbn5", "sbn6"]
    svc_name        = "com.amazonaws.ap-northeast-2.ecr.api"
    sg_index        = ["dev_vpce_pri"]
    pri_dns_enabled = true
    purpose         = "ecrapi"
    type            = "vpce"
  },
  { index           = "ecr-dkr"
    vpc_index       = "moo_dev"
    sub_index       = ["sbn5", "sbn6"]
    svc_name        = "com.amazonaws.ap-northeast-2.ecr.dkr"
    sg_index        = ["dev_vpce_pri"]
    pri_dns_enabled = true
    purpose         = "ecr-api"
    type            = "vpce"
  },
  { index           = "s3"
    vpc_index       = "moo_dev"
    sub_index       = ["sbn5", "sbn6"]
    svc_name        = "com.amazonaws.ap-northeast-2.s3"
    sg_index        = ["dev_vpce_pri"]
    pri_dns_enabled = false
    purpose         = "s3"
    type            = "vpce"
  },
  { index           = "elb"
    vpc_index       = "moo_dev"
    sub_index       = ["sbn5", "sbn6"]
    svc_name        = "com.amazonaws.ap-northeast-2.elasticloadbalancing"
    sg_index        = ["dev_vpce_pri"]
    pri_dns_enabled = true
    purpose         = "elb"
    type            = "vpce"
  },
  { index           = "cwlog"
    vpc_index       = "moo_dev"
    sub_index       = ["sbn5", "sbn6"]
    svc_name        = "com.amazonaws.ap-northeast-2.logs"
    sg_index        = ["dev_vpce_pri"]
    pri_dns_enabled = true
    purpose         = "cwlog"
    type            = "vpce"
  },
  { index           = "sts"
    vpc_index       = "moo_dev"
    sub_index       = ["sbn5", "sbn6"]
    svc_name        = "com.amazonaws.ap-northeast-2.sts"
    sg_index        = ["dev_vpce_pri"]
    pri_dns_enabled = true
    purpose         = "sts"
    type            = "vpce"
  }
]