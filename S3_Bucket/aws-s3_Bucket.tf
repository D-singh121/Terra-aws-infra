provider "aws" {
  region = "ap-south-1"
}


resource "aws_s3_bucket" "my_bucket_1" {
  bucket = "my-tf-bucket-dsingh-20240504"
  force_destroy = true
  tags = {
    Name        = "My S3 bucket"
    Environment = "Dev"
  }
}
