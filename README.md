# DF Test Task

Infrastructure and local runtime for a 3-tier web application:
- Frontend (Nginx + static landing)
- Backend (Node.js API)
- Database (PostgreSQL)

## Local run (Docker Compose)

Create local secret values first:

```bash
cp .env.example .env
```

```bash
docker compose up --build
```

Then open [http://localhost:8080](http://localhost:8080) and click **Check backend health**.

## Terraform

Terraform stack is under:
- Root stack: `terraform/df_cust_example/aws_df_resources`
- Reusable module: `terraform/modules/aws_df_ec2_resources`

## Improvment points

1. Terraform generated secrets for DB stored in AWS Secret manager.
2. docker/ folder split into separate repositories for Frontend and Backend parts of application with CI/CD automations.
3. Enforcing privacy for the repository in production grade/internal worflows.