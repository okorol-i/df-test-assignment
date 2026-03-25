## Directory Overview

This folder contains Terraform configuration for deploying AWS infrastructure components used for the DF example customer AWS account.

### Folder Structure

- `aws_s3/`  
  Provisions a static S3 bucket for hosting frontend assets as infrastructure-as-code (IaC).

- `aws_alb/`  
  Defines an AWS Application Load Balancer (ALB), including listeners, target groups, and security group rules for routing external traffic to backend resources.

- `aws_cloudfront/`  
  Sets up an AWS CloudFront distribution to serve content with global low latency, integrating with S3 (for static assets) and the ALB (for dynamic/backend resources).

- `aws_df_resources/`  
  Contains the root configurations for this example's AWS stack. This directory acts as the main entry point to provision one or more EC2-based environments, and wires in the reusable infrastructure module found at `../../modules/aws_df_ec2_resources`.

### Notes

- Each subfolder is self-contained, with its own variables and configuration files.  
- Adjust variable values as needed for your environment or deployment scenario.  
- Secrets and credentials should not be committed; use secure variable injection methods.

Refer to the respective folder READMEs or source files for detailed module usage and available input variables.