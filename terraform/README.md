## Terraform (AWS)

This repo provisions a simple 3-tier setup:
- `frontend` EC2 (running Docker/Nginx)
- `backend` EC2 (running the Node API)
- `db` EC2 (PostgreSQL host, plus security/networking)
- networking (VPC, subnets, NAT/IGW, route tables, security groups)
- static frontend origin (S3) + CDN (CloudFront)
- optional integration via an internet-facing ALB (Pattern B)

### Entry point stack
Terraform entry point is here:
- `terraform/df_cust_example/aws_df_resources`

### Reusable module
Core infrastructure module:
- `terraform/modules/aws_df_ec2_resources`

### How to run
From the entry point directory:
```bash
cd terraform/df_cust_example/aws_df_resources
terraform init
terraform plan
terraform apply
```

### Notes
- Secrets should be provided via Terraform variables / external mechanisms (do not commit credentials).
- For this exercise, database credentials are not wired into EC2 via Terraform user data; the compose setup demonstrates the wiring locally.
