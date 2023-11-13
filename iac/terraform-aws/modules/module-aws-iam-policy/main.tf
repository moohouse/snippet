resource "aws_iam_policy" "this" {
  for_each = { for _map in var.iam_policy_create : _map.index => _map }
  name     = join("-", [var.common_tags.Company, var.common_tags.Service, var.common_tags.Environment, each.value.policy_name])

  policy = file("${each.value.policy}")

  tags = merge(
    var.common_tags,
    {
      Type = "iam-policy"
      Name = join("-", [
        var.common_tags.Company,
        var.common_tags.Service,
        var.common_tags.Environment,
        each.value.policy_name
      ])
    }
  )
}