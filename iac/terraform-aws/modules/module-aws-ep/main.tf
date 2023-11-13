resource "aws_vpc_endpoint" "vpc_ep_interface" {
  for_each = { for _map in var.ep_interface_create : _map.index => _map }
  vpc_id   = var.vpc_info[each.value.vpc_index].id

  subnet_ids         = [for sub_ids in each.value.sub_index : var.subnet_info[sub_ids].id]
  security_group_ids = [for sg_ids in each.value.sg_index : var.sg_info[sg_ids].id]

  service_name      = each.value.svc_name
  vpc_endpoint_type = "Interface"


  private_dns_enabled = lookup(each.value, "pri_dns_enabled", null)

  tags = merge(
    var.common_tags,
    {
      Type    = each.value.type
      Purpose = each.value.purpose
      Name = join("-",
        [var.common_tags.Company,
          var.common_tags.Service,
          var.common_tags.Environment,
          each.value.purpose,
      each.value.type])
  })
}

resource "aws_vpc_endpoint" "vpc_ep_gateway" {
  for_each = { for _map in var.ep_gateway_create : _map.index => _map }
  vpc_id   = var.vpc_info[each.value.vpc_index].id

  route_table_ids = [for rtb_ids in each.value.rtb_index : var.rtb_info[rtb_ids].id]

  service_name      = each.value.svc_name
  vpc_endpoint_type = "Gateway"

  tags = merge(
    var.common_tags,
    {
      Type    = each.value.type
      Purpose = each.value.purpose
      Name = join("-",
        [var.common_tags.Company,
          var.common_tags.Service,
          var.common_tags.Environment,
          each.value.purpose,
      each.value.type])
  })

}


