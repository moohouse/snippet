resource "aws_subnet" "this" {
  for_each = { for sbn_map in var.subnet_create : sbn_map.index => sbn_map }

  vpc_id = var.vpc_info[each.value.vpc_index].id

  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr_block

  # AUTO-ASSIGN PUBLIC IP
  map_public_ip_on_launch = contains(["true", "false"], lookup(each.value, "map_public_ip_on_launch", null)) && contains(["public"], lookup(each.value, "position", null)) ? each.value.map_public_ip_on_launch : "false"

  tags = merge(
    {
      Type = each.value.type
      Name = join("-", [
        var.common_tags.Company,
        var.common_tags.Service,
        var.common_tags.Environment,
        each.value.purpose,
        substr(each.value.position, 0, 3),
        format("apne%s", substr(each.value.availability_zone, -2, -1)),
        each.value.type
      ])
    },
    var.common_tags,
    lookup(each.value, "custom_tags", null)
  )

  #depends_on = [
  #  aws_vpc.this,
  #  aws_vpc_ipv4_cidr_block_association.this
  #]
}