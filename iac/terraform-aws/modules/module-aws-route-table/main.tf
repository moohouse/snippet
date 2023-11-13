resource "aws_route_table" "this" {
  for_each = { for rt_map in var.subnet_create : rt_map.index => rt_map }

  vpc_id = var.vpc_info[each.value.vpc_index].id

  tags = merge(
    var.common_tags,
    {
      Type = "rt"
      Name = join("-", [
        var.common_tags.Company,
        var.common_tags.Service,
        var.common_tags.Environment,
        each.value.purpose,
        each.value.position,
        format("apne%s", substr(each.value.availability_zone, -2, -1)),
        "rt",
      ])
    }
  )
}

resource "aws_route_table_association" "this" {
  for_each       = { for rt_map in var.subnet_create : join(".", [rt_map.index, rt_map.cidr_block]) => rt_map }
  subnet_id      = var.subnet_info[each.value.index].id
  route_table_id = aws_route_table.this[each.value.index].id
}

resource "aws_route" "this" {
  for_each       = { for r_map in var.rt_rule_data : join(".", [r_map.sub_index, r_map.vpc, r_map.dst_cidr]) => r_map }
  route_table_id = aws_route_table.this[each.value.sub_index].id

  destination_cidr_block = length(regexall("^([0-9]{1,3}.){3}[0-9]{1,3}/(([0-9]|1[0-9]|2[0-8]|3[0-2]))$", each.value.dst_cidr)) > 0 ? each.value.dst_cidr : null

  gateway_id     = length(lookup(each.value, "igw", "")) > 0 ? length(regexall("^vgw", each.value.igw)) > 0 ? var.vgw_info[each.value.igw].id : var.igw_info[each.value.igw].id : null
  nat_gateway_id = length(lookup(each.value, "nat", "")) > 0 ? var.nat_info[each.value.nat].id : null
  # vpc_endpoint_id          =  #vpc endpoint module에서 gateway type enpoint 생성 후 route table associate
  # transit_gateway_id        =  #추가되는 route 옵션 업데이트 필요
  vpc_peering_connection_id = length(lookup(each.value, "pcx", "")) > 0 ? var.vpc_peering_info[each.value.pcx].id : null
  # destination_prefix_list_id = 
  # instance_id               = 
  depends_on = [aws_route_table.this]

}