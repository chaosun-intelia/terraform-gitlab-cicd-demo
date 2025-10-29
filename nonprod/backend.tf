terraform {
  backend "s3" {
    bucket  = "chaodev-tf-state-bucket"
    key     = "nonprod/terraform.tfstate"
    region  = "ap-southeast-2"
    encrypt = true
  }
}
