output "eks_cluster_info" {
  value       = aws_eks_cluster.this
  description = "eks cluster information map type output."
}
