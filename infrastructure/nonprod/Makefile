# Makefile for Terraform GCP Projects

.PHONY: help init fmt plan apply destroy

# PLAN_FILE remains the same
PLAN_FILE = "tfplan"

# The default command, executed when you just run "make".
DEFAULT_GOAL := help
help:
	@echo "Makefile for Terraform GCP"
	@echo ""
	@echo "Usage:"
	@echo "  make init      - Initialize Terraform with the S3 backend"
	@echo "  make fmt       - Format the Terraform code"
	@echo "  make plan      - Create a Terraform execution plan"
	@echo "  make apply     - Apply the Terraform plan"
	@echo "  make destroy   - Destroy all managed resources"
	@echo ""

# Initialize Terraform with the specified remote backend configuration.
init:
	@echo "🚀 Initializing Terraform with S3 backend..."
	@terraform init

# Format the Terraform code for consistency.
fmt:
	@echo "💅 Formatting Terraform code..."
	@terraform fmt -recursive

# Create an execution plan and save it to a file.
plan:
	@echo "📝 Creating Terraform execution plan..."
	@terraform plan -out=$(PLAN_FILE)

# Apply the saved execution plan.
apply:
	@echo "✅ Applying Terraform plan..."
	@terraform apply "$(PLAN_FILE)"

# Destroy all resources managed by this configuration.
destroy:
	@echo "🔥 Destroying all resources..."
	@terraform destroy -auto-approve
