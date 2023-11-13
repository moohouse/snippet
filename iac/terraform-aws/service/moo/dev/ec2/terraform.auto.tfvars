common_tags = {
    Company     = "Mooheadtown"
    Service     = "moo"
    Project     = "moo"
    Environment = "dev"
}

ec2_bastion_create = [{
  index            = "ec2-bastion"
  ami              = "ami-03db74b70e1da9c56"
  instance_type    = "t2.micro"
  sub_index        = "sbn1"
  sg_index         = ["dev_bastion_pub"]
  key_name         = "bastion-key"
  volume_size      = 8
  volume_type      = "gp3"
  eip_required     = true
  network_boundary = "pub"
  purpose          = "bastion"
  region_az        = "apne2a"
  type             = "ec2"
  },
  {
    index            = "ec2-efs"
    ami              = "ami-03db74b70e1da9c56"
    instance_type    = "t2.micro"
    sub_index        = "sbn5"
    sg_index         = ["dev_efsec2_pri"]
    key_name         = "efs-key"
    volume_size      = 8
    volume_type      = "gp3"
    eip_required     = false
    network_boundary = "pri"
    purpose          = "efs"
    region_az        = "apne2a"
    type             = "ec2"
}]
