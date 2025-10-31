# chaodev-terraform

Terraform infrastructure as code for AWS resources with automated GitLab CI/CD pipeline.

## Overview

This project manages AWS infrastructure using Terraform with a GitLab CI/CD pipeline that automatically validates, plans, and deploys infrastructure changes.

## Architecture

- **Region**: ap-southeast-2 (Sydney)
- **State Backend**: 
  - Non-production: GitLab HTTP backend
  - Production: S3 bucket with remote state storage
- **Authentication**: AWS OIDC with GitLab
- **Environments**: Non-production (dev) and Production (main)

## Infrastructure Components

### Current Resources
- S3 bucket with random suffix for uniqueness
- IAM roles and policies
- Remote state management

### Directory Structure
```
├── nonprod/
│   ├── backend.tf      # S3 backend configuration
│   ├── provider.tf     # AWS and random providers
│   ├── iam.tf         # IAM resources
│   └── s3.tf          # S3 bucket resources
└── .gitlab-ci.yml     # CI/CD pipeline
```

## CI/CD Pipeline

The pipeline consists of three stages:

1. **Validate**: Checks Terraform syntax and configuration
2. **Plan**: Creates execution plan and stores as artifact
3. **Apply**: Deploys infrastructure

### Pipeline Features
- AWS OIDC authentication
- Dual backend configuration:
  - **Non-prod**: GitLab HTTP backend (automatic apply on dev branch)
  - **Production**: S3 remote state backend (manual approval on main branch)
- Artifact storage for plan files
- Environment-specific IAM roles

## Setup

### Prerequisites
1. AWS account with OIDC configured for GitLab
2. S3 bucket for production Terraform state
3. IAM roles with appropriate permissions for both environments

For AWS OIDC setup guide: https://docs.gitlab.com/ci/cloud_services/aws/

For Gitlab OIDC, keep both Provider URL and Audience to https://gitlab.com.
Attach IAM roles based on your needs (S3, EC2, IAM permissions, etc.).

### GitLab Variables
Add these variables in GitLab project settings:
- `AWS_ROLE_ARN_NONPROD`: ARN of the AWS IAM role for non-production
- `AWS_ROLE_ARN_PROD`: ARN of the AWS IAM role for production
- `GITLAB_ACCESS_TOKEN`: Token for GitLab HTTP backend access

### Backend Configuration
- **Non-production**: Uses GitLab HTTP backend for state storage
- **Production**: Uses S3 bucket (`chao-terraform-tf-state-bucket-780a`) for state storage

## Usage

### Local Development
```bash
cd nonprod
terraform init
terraform plan
terraform apply
```

### Pipeline Deployment

**Non-production (dev branch):**
1. Push changes to dev branch
2. Pipeline runs validate + plan + apply automatically

**Production (main branch):**
1. Push changes to main branch (runs validate + plan)
2. Manually trigger apply stage in GitLab pipeline

## Security
- Uses AWS OIDC for secure authentication
- No long-lived AWS credentials stored
- Manual approval required for infrastructure changes
- State file encrypted in S3

## Terraform Versions
- Terraform: >= 1.0
- AWS Provider: ~> 5.0
- Random Provider: ~> 3.0