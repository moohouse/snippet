# Security Gruop
resource "aws_security_group" "this" {
  for_each = { for s_map in toset(distinct([for index, rule in var.sg_rule_data : tomap({ rulename = rule.name, vpc = rule.vpc, purpose = rule.purpose, position = rule.position })])) : s_map.rulename => s_map }

  name   = join("-", [var.common_tags.Company, var.common_tags.Service, var.common_tags.Environment, each.value.purpose, each.value.position, "sg"]) ## 
  vpc_id = var.vpc_info[each.value.vpc].id

  tags = merge(
    var.common_tags,
    {
      Type = "sg"
      Name = join("-", [
        var.common_tags.Company,
        var.common_tags.Service,
        var.common_tags.Environment,
        each.value.purpose,
        each.value.position,
        "sg"
      ])
    }
  )
  lifecycle {
    ignore_changes = [name, description, tags]
  }

  depends_on = [
    var.vpc_info
  ]
}

#Security Group Rule
resource "aws_security_group_rule" "this" {
  for_each = { for s_map in var.sg_rule_data : join(".", [s_map.name, s_map.vpc, s_map.type, s_map.from_port, s_map.to_port, s_map.protocol, s_map.source, s_map.src_sg, s_map.purpose]) => s_map }

  type                     = each.value.type
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  cidr_blocks              = length(regexall("^([0-9]{1,3}.){3}[0-9]{1,3}/(([0-9]|1[0-9]|2[0-8]|3[0-2]))$", each.value.source)) > 0 ? [each.value.source] : null
  self                     = each.value.source == "self" ? true : null
  prefix_list_ids          = substr(each.value.source, 0, 2) == "pl" ? [each.value.source] : null
  source_security_group_id = lookup(each.value, "src_sg", null) == "" ? null : aws_security_group.this[each.value.src_sg].id
  #source_security_group_id = length(regexall("^[a-z]", each.value.sg_src)) > 0 ? aws_security_group.this[each.value.sg_src].id : null
  #prefix_list_ids          = substr(each.value.sg_pl, 0, 2) == "pl" ? [each.value.sg_pl] : null
  description       = each.value.description
  security_group_id = aws_security_group.this[each.value.name].id
}

