resource "aws_iam_role" "this" {
  name = join("-", [var.common_tags.Company, var.common_tags.Service, var.common_tags.Environment, "mwaaExcutionRole"])

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "airflow-env.amazonaws.com",
                    "airflow.amazonaws.com"
                ]
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
        "mwaaExcutionRole"
      ])
    }
  )

}

resource "aws_iam_policy" "policy" {
  for_each    = { for _map in var.mwaa_policy_create : _map.index => _map }
  name        = join("-", [var.common_tags.Company, var.common_tags.Service, var.common_tags.Environment, "mwaaExcutionPolicy"])
  description = lookup(each.value, "policy_description", null)
  policy      = file("${each.value.policy}")

  tags = merge(
    var.common_tags,
    lookup(each.value, "custom_tags", null),
    {
      Type = "policy"
      Name = join("-",
        [var.common_tags.Company,
          var.common_tags.Service,
          var.common_tags.Environment,
      "mwaaExcutionPolicy"])
  })

}

resource "aws_iam_role_policy_attachment" "attach" {
  for_each   = { for _map in var.mwaa_policy_attach : _map.index => _map }
  policy_arn = lookup(each.value, "custom_policy_index", null) == null ? lookup(each.value, "policy_arn", null) : aws_iam_policy.policy[each.value.custom_policy_index].arn
  role       = aws_iam_role.this.name
}