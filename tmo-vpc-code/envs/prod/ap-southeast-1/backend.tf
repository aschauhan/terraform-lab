terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket" # <-- REPLACE with your bucket
    key    = "terraform/state/prod/ap-southeast-1/vpc.tfstate"
    region = "ap-southeast-1"
    encrypt = true
    dynamodb_table = "terraform-locks" # <-- optional: replace or remove
  }
}
