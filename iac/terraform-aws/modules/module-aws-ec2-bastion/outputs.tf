output "ec2_bastion_info" {
  value       = aws_instance.bastion
  description = "bastion ec2 information map type output"
}