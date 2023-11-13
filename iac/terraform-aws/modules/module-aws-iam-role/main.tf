resource "aws_iam_role" "this" {
  for_each = { for _map in var.iam_role_create : _map.index => _map }
  name     = join("-", [var.common_tags.Company, var.common_tags.Service, var.common_tags.Environment, each.value.role_name])

  assume_role_policy = file("${each.value.assume_role_policy}")

  tags = merge(
    var.common_tags,
    {
      Type = "iam-role"
      Name = join("-", [
        var.common_tags.Company,
        var.common_tags.Service,
        var.common_tags.Environment,
        each.value.role_name
      ])
    }
  )

}


resource "aws_iam_role_policy_attachment" "managed_policy" {
  for_each = { for _map in var.iam_managed_policy_attatch_create : _map.index => _map }

  policy_arn = format("arn:aws:iam::aws:policy/%s", each.value.managed_policy_name)
  role       = aws_iam_role.this[each.value.iam_role_index].name
}

resource "aws_iam_role_policy_attachment" "custom_policy" {
  for_each = { for _map in var.iam_custom_policy_attatch_create : _map.index => _map }

  policy_arn = var.iam_policy_info[each.value.iam_policy_index].arn
  role       = aws_iam_role.this[each.value.iam_role_index].name
}