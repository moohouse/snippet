resource "aws_eks_cluster" "this" {
  for_each = { for eks_map in var.eks_cluster_create : eks_map.index => eks_map }

  name                      = join("-", [var.common_tags.Company, var.common_tags.Service, var.common_tags.Environment, each.value.name])
  role_arn                  = aws_iam_role.this.arn
  version                   = each.value.cluster_version
  enabled_cluster_log_types = each.value.enabled_cluster_log_types

  vpc_config {
    subnet_ids              = [for sub_ids in each.value.sub_index : var.subnet_info[sub_ids].id]
    endpoint_private_access = each.value.endpoint_private_access
    endpoint_public_access  = each.value.endpoint_public_access
  }

  lifecycle {
    ignore_changes = [version, tags]
  }

  depends_on = [aws_iam_role_policy_attachment.cluster_managed_policy]


  tags = merge(
    var.common_tags,
    lookup(each.value, "custom_tags", null),
    {
      Type = each.value.type
      Name = join("-", [
        var.common_tags.Company,
        var.common_tags.Service,
        var.common_tags.Environment,
        each.value.name
      ])
    }
  )
}

resource "aws_eks_addon" "this" {
  for_each = { for _map in var.eks_addon_create : _map.index => _map }

  cluster_name      = aws_eks_cluster.this[each.value.cluster_index].name
  addon_name        = each.value.addon_name
  addon_version     = lookup(each.value, "addon_version", null)
  resolve_conflicts = each.value.resolve_conflicts

  tags = merge(
    var.common_tags,
    {
      Type = "eks-addon"
      Name = join("-", [
        var.common_tags.Company,
        var.common_tags.Service,
        var.common_tags.Environment,
        each.value.addon_name
      ])
    }
  )
}