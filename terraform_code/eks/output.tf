output "endpoint" {
  value = aws_eks_cluster.eks.endpoint
}
output "security_group_public" {
   value = aws_security_group.worker_node_sg.id
}
# output "private_key_pem" {
#   value = tls_private_key.my_key.private_key_pem
#   sensitive = true
# }
