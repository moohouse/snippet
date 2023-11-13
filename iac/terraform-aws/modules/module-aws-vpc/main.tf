
## VPC 
resource "aws_vpc" "this" {
  for_each = { for v_map in var.vpc_create : v_map.index => v_map if lookup(v_map, "type", null) == "vpc" }

  cidr_block                       = each.value.cidr_block
  instance_tenancy                 = each.value.instance_tenancy
  enable_dns_hostnames             = each.value.enable_dns_hostnames
  enable_dns_support               = each.value.enable_dns_support
  assign_generated_ipv6_cidr_block = each.value.enable_ipv6

  tags = merge(
    var.common_tags,
    {
      Type = each.value.type
      Name = join("-", [
        var.common_tags.Company,
        var.common_tags.Service,
        var.common_tags.Environment,
        each.value.type
      ])
    }
  )
}
## VPC Internet gateway
resource "aws_internet_gateway" "this" {
  for_each = { for i_map in var.vpc_create : i_map.index => i_map if lookup(i_map, "aws_internet_gateway", false) }

  vpc_id = aws_vpc.this[each.value.index].id

  tags = merge(
    var.common_tags,
    {
      Type = "igw"
      Name = join("-", [var.common_tags.Company, var.common_tags.Service, var.common_tags.Environment, each.value.type, "igw"])
    }
  )

  depends_on = [
    aws_vpc.this
  ]
}