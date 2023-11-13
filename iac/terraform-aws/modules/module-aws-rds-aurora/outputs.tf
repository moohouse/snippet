output "rds_cluster_info" {
  value       = aws_rds_cluster.aurora_cluster
  description = "aurora cluster information map type output."
}

output "rds_cluster_instance_info" {
  value       = aws_rds_cluster_instance.aurora_cluster_instances
  description = "aurora cluster instances information map type output."
}

output "aurora_rds_kms_info" {
  value       = aws_kms_key.aurora_rds_kms_key
  description = "rds kms key information map type output."
}