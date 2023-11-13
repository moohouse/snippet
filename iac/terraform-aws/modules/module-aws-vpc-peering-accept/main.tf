#peering 연결 후, 요청자측에서만 peering 삭제 가능
#accepter에서는 state에서는 제거 되지만 연결은 삭제되지 않음
resource "aws_vpc_peering_connection_accepter" "this" {
  for_each                  = { for vpa_map in var.vpc_peering_accept_create : vpa_map.index => vpa_map }
  vpc_peering_connection_id = each.value.vpc_peering_connection_id
  auto_accept               = each.value.auto_accept

  tags = merge(
    var.common_tags,
    {
      Side = "Accepter"
      Type = "vpc-peering"
      Name = join("-", [
        each.value.index,
        # var.common_tags.Company,
        # var.common_tags.Service,
        # var.common_tags.Environment,
        "vpc-peering"
      ])
    }
  )
}