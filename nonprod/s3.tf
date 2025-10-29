resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "new_bucket" {
  bucket = "chaodev-tf-managed-bucket-${random_id.bucket_suffix.hex}"
  tags = {
    Name        = "chaodev-tf-managed-bucket-${random_id.bucket_suffix.hex}"
    Environment = "dev"
  }
}
