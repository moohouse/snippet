output "ec2_info" {
  value       = aws_instance.ec2
  description = "ec2 information map type output"
}

output "iam_info" {
  value       = aws_iam_role.ec2
  description = "ec2 iam role information map type output"
}