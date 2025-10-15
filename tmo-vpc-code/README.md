tf-own-module-vpc — modular Terraform example
-------------------------------------------------
Structure:
- modules/vpc : reusable VPC module
- envs/<env>/<region> : environment + region-specific Terraform root

Each env/region has its own backend (S3) and state file so state is isolated per environment and region.

How to use (example for dev/ap-south-1):

cd envs/dev/ap-south-1
# Edit provider.tf to set region or use terraform.tfvars
# Edit backend.tf to set your S3 bucket and dynamodb table
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"

Notes:
- Replace bucket names, kms_key_arn, and dynamodb_table names in backend.tf with your infrastructure values.
- backend.tf in each env/region is preconfigured to store state at key "terraform/state/<env>/<region>/vpc.tfstate"
- You can add more regions by copying any env/<env>/<region> folder.
