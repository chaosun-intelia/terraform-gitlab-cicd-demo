terraform {
  backend "s3" {
    bucket  = "chao-terraform-tf-state-bucket-780a"
    key     = "prod/terraform.tfstate"
    region  = "ap-southeast-2"
    encrypt = true
  }
}