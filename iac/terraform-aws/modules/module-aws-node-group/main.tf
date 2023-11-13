resource "aws_eks_node_group" "this" {
  for_each = { for ng_map in var.eks_node_group_create : ng_map.index => ng_map }

  cluster_name    = var.eks_cluster_info[each.value.cluster_index].name
  node_group_name = join("-", [var.common_tags.Company, var.common_tags.Service, var.common_tags.Environment, each.value.name])
  node_role_arn   = aws_iam_role.this.arn
  subnet_ids      = [for sub_ids in each.value.sub_index : var.subnet_info[sub_ids].id]

  ami_type       = lookup(each.value, "ami_type", null)
  capacity_type  = lookup(each.value, "capacity_type", null)
  disk_size      = lookup(each.value, "disk_size", null)
  instance_types = lookup(each.value, "instance_types", null)

  scaling_config {
    desired_size = each.value.desired_size
    max_size     = each.value.max_size
    min_size     = each.value.min_size
  }

  labels = lookup(each.value, "labels", {})

  remote_access {
    ec2_ssh_key               = lookup(each.value, "ec2_ssh_key", null)
    source_security_group_ids = lookup(each.value, "sg_index", null) == null ? null : [for sg_ids in each.value.sg_index : var.sg_info[sg_ids].id]
  }

  depends_on = [aws_iam_role_policy_attachment.ng_managed_policy, aws_iam_role_policy_attachment.ng_custom_policy] #, aws_iam_service_linked_role.AWSServiceRoleForAmazonEKSNodegroup]

  tags = merge(
    var.common_tags,
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
  lifecycle {
    ignore_changes = [remote_access]
  }
}

# resource "aws_iam_service_linked_role" "AWSServiceRoleForAmazonEKSNodegroup" {
#   aws_service_name = "eks-nodegroup.amazonaws.com"
# }