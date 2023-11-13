common_tags = {
    Company     = "Mooheadtown"
    Service     = "moo"
    Project     = "moo"
    Environment = "dev"
}

vpc_peering_request_create = [
  {
    index         = "isc"
    peer_owner_id = "603938493041"          #peering 요청할 상대 account
    peer_vpc_id   = "vpc-0198ecbdccb185bca" #peering 요청 대상 vpc id  
    vpc_index     = "moo_dev"               #요청자 vpc id
    auto_accept   = false

  }
]

vpc_peering_accept_create = [
  {
    index                     = "mongodb"
    vpc_peering_connection_id = "pcx-0f2750a4657ee0322"
    auto_accept               = true

  }
]

vgw_create = [
  {
    index     = "vgw_1"
    type      = "vgw"
    vpc_index = "moo_dev"
  }
]