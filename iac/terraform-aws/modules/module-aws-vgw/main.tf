resource "aws_vpn_gateway" "vpn_vgw" {
  for_each = { for _map in var.vgw_create : _map.index => _map }

  vpc_id = var.vpc_info[each.value.vpc_index].id

  tags = merge(
    var.common_tags,
    {
      Type = each.value.type
      Name = join("-", [
        var.common_tags.Company,
        var.common_tags.Service,
        var.common_tags.Environment,
        "vgw"
      ])
    }
  )
}