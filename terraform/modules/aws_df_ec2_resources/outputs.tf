output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC ID"
}

output "frontend_private_ip" {
  value       = aws_instance.frontend.private_ip
  description = "Private IP of frontend EC2 (ALB target)"
}

output "backend_private_ip" {
  value       = aws_instance.backend.private_ip
  description = "Backend private IP"
}

output "db_private_ip" {
  value       = aws_instance.db.private_ip
  description = "PostgreSQL private IP"
}

output "cloudfront_domain_name" {
  value       = aws_cloudfront_distribution.frontend_cdn.domain_name
  description = "CloudFront DNS name"
}

output "alb_dns_name" {
  value       = aws_lb.frontend.dns_name
  description = "Public ALB DNS"
}

output "frontend_bucket_name" {
  value       = aws_s3_bucket.frontend_static.bucket
  description = "S3 bucket name for static frontend offerings"
}
