output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}
output "eks_cluster_name" {
  value = module.eks.cluster_name
}
output "rds_endpoint" {
  value = module.rds.db_instance_endpoint
}