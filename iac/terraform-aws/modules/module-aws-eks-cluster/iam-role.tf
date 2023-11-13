resource "aws_iam_role" "this" {
  name = join("-", [var.common_tags.Company, var.common_tags.Service, var.common_tags.Environment, "eksClusterRole"])

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
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
        "eksClusterRole"
      ])
    }
  )

}

resource "aws_iam_role_policy_attachment" "cluster_managed_policy" {
  for_each = { for _map in var.cluster_managed_policy_create : _map.index => _map }

  policy_arn = format("arn:aws:iam::aws:policy/%s", each.value.policy_name)
  role       = aws_iam_role.this.name
}