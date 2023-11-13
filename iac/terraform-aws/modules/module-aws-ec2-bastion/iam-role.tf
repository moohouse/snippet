resource "aws_iam_role" "ec2-bastion" {
  name               = join("-", [var.common_tags.Company, var.common_tags.Service, var.common_tags.Environment, "ec2BastionRole"])
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
      Name = join("-",
        [var.common_tags.Company,
          var.common_tags.Service,
          var.common_tags.Environment,
      "ec2BastionRole"])
  })

}

resource "aws_iam_role_policy_attachment" "ssm_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.ec2-bastion.name
}

resource "aws_iam_instance_profile" "ec2_bastion_profile" {
  name = join("-", [var.common_tags.Company, var.common_tags.Service, var.common_tags.Environment, "ec2BastionInstanceProfile"])
  role = aws_iam_role.ec2-bastion.name

  tags = merge(
    var.common_tags,
    {
      Name = join("-",
        [var.common_tags.Company,
          var.common_tags.Service,
          var.common_tags.Environment,
      "ec2BastionInstanceProfile"])
  })
}
