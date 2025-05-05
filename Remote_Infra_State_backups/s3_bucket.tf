resource "aws_s3_bucket" "my_bucket_1" {
  bucket        = "my-tf-state-bucket-dsingh-20250505"
  force_destroy = true
  tags = {
    Name        = "My S3 state management bucket with dynamoDb on aws."
    Environment = "Dev"
  }
}
