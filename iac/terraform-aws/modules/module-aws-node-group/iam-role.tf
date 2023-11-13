resource "aws_iam_role" "this" {
  name = join("-", [var.common_tags.Company, var.common_tags.Service, var.common_tags.Environment, "AmazonEKSNodeRole"])

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = merge(
    var.common_tags,
    {
      Type = "role"
      Name = join("-", [
        var.common_tags.Company,
        var.common_tags.Service,
        var.common_tags.Environment,
        "AmazonEKSNodeRole"
      ])
    }
  )

}

resource "aws_iam_policy" "ng_custom_policy" {
  for_each = { for _map in var.ng_custom_policy_create : _map.index => _map }
  name     = join("-", [var.common_tags.Company, var.common_tags.Service, var.common_tags.Environment, each.value.policy_name])

  policy = file("${each.value.iam_policy}")

}

resource "aws_iam_role_policy_attachment" "ng_custom_policy" {
  for_each = { for _map in var.ng_custom_policy_create : _map.index => _map }

  policy_arn = aws_iam_policy.ng_custom_policy[each.value.index].arn
  role       = aws_iam_role.this.name
}


resource "aws_iam_role_policy_attachment" "ng_managed_policy" {
  for_each = { for _map in var.ng_managed_policy_create : _map.index => _map }

  policy_arn = format("arn:aws:iam::aws:policy/%s", each.value.policy_name)
  role       = aws_iam_role.this.name
}