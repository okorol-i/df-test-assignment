output "vpc_id" {
  value       = module.df_example_module.vpc_id
  description = "ID of created VPC"
}

output "frontend_private_ip" {
  value       = module.df_example_module.frontend_private_ip
  description = "Private IP of frontend EC2"
}

output "backend_private_ip" {
  value       = module.df_example_module.backend_private_ip
  description = "Private IP of backend EC2"
}

output "db_private_ip" {
  value       = module.df_example_module.db_private_ip
  description = "Private IP of PostgreSQL EC2"
}

output "cloudfront_domain_name" {
  value       = module.df_example_module.cloudfront_domain_name
  description = "CloudFront DNS name"
}

output "alb_dns_name" {
  value       = module.df_example_module.alb_dns_name
  description = "ALB DNS name"
}

output "frontend_bucket_name" {
  value       = module.df_example_module.frontend_bucket_name
  description = "S3 bucket for frontend static offerings"
}
