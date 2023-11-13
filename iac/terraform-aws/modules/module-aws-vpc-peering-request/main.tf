resource "aws_vpc_peering_connection" "this" {
  for_each      = { for vpr_map in var.vpc_peering_request_create : vpr_map.index => vpr_map }
  peer_owner_id = each.value.peer_owner_id
  peer_vpc_id   = each.value.peer_vpc_id
  vpc_id        = var.vpc_info[each.value.vpc_index].id
  auto_accept   = each.value.auto_accept

  tags = merge(
    var.common_tags,
    {
      Side = "Requester"
      Type = "vpc-peering"
      Name = join("-", [
        var.common_tags.Company,
        var.common_tags.Service,
        var.common_tags.Environment,
        "vpc-peering"
      ])
    }
  )
}


