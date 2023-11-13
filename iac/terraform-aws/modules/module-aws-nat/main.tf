resource "aws_nat_gateway" "nat" {
  for_each      = { for _map in var.nat_create : _map.index => _map }
  allocation_id = aws_eip.nat_eip[each.value.index].id
  subnet_id     = var.subnet_info[each.value.sub_index].id

  tags = merge(
    var.common_tags,
    {
      Type           = each.value.type
      NetworkBoudary = each.value.networkboudary
      Name = join("-",
        [var.common_tags.Company,
          var.common_tags.Service,
          var.common_tags.Environment,
          each.value.networkboudary,
      each.value.type])
  })

  depends_on = [aws_eip.nat_eip]
}

resource "aws_eip" "nat_eip" {
  for_each = { for _map in var.nat_create : _map.index => _map }
  vpc      = true

  tags = merge(
    var.common_tags,
    {
      Type           = "eip"
      NetworkBoudary = each.value.networkboudary
      Name = join("-",
        [var.common_tags.Company,
          var.common_tags.Service,
          var.common_tags.Environment,
          each.value.networkboudary,
          each.value.type,
      "eip"])
  })
}