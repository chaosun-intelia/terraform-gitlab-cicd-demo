# chaodev-terraform

Terraform infrastructure as code for AWS resources with automated GitLab CI/CD pipeline.

## Overview

This project manages AWS infrastructure using Terraform with a GitLab CI/CD pipeline that automatically validates, plans, and deploys infrastructure changes.

## Architecture

- **Region**: ap-southeast-2 (Sydney)
- **State Backend**: S3 bucket with remote state storage
- **Authentication**: AWS OIDC with GitLab
- **Environment**: Non-production

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
3. **Apply**: Deploys infrastructure (manual trigger, main branch only)

### Pipeline Features
- AWS OIDC authentication
- Terraform provider caching
- S3 remote state backend
- Manual approval for apply stage
- Artifact storage for plan files

## Setup

### Prerequisites
1. AWS account with OIDC configured for GitLab
2. S3 bucket for Terraform state: `chaodev-tf-state-bucket`
3. IAM role with appropriate permissions

For AWS OIDC setup guide: https://docs.gitlab.com/ci/cloud_services/aws/

For Gitlab OIDC, keep both Provider URL and Audience to https://gitlab.com.
Attach IAM roles based on your needs (S3, EC2, IAM permissions, etc.).
### GitLab Variables
Add these variables in GitLab project settings:
- `AWS_ROLE_ARN_NONPROD`: ARN of the AWS IAM role for OIDC

### Configuration
Update variables in `.gitlab-ci.yml`:
```yaml
variables:
  TF_STATE_BUCKET: "your-terraform-state-bucket"
  TF_STATE_KEY: "terraform.tfstate"
  TF_STATE_REGION: "ap-southeast-2"
```

## Usage

### Local Development
```bash
cd nonprod
make init
make plan
make apply
```

### Pipeline Deployment
1. Push changes to feature branch (runs validate + plan)
2. Create merge request
3. Merge to main branch
4. Manually trigger apply stage in GitLab pipeline

## Security
- Uses AWS OIDC for secure authentication
- No long-lived AWS credentials stored
- Manual approval required for infrastructure changes
- State file encrypted in S3

## Terraform Versions
- Terraform: >= 1.0
- AWS Provider: ~> 5.0
- Random Provider: ~> 3.0