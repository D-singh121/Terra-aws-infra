resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name         = "RemoteInfraStateDB"
  billing_mode = "PAY_PER_REQUEST" // On-demand mode
  hash_key     = "LockID"          // naming convention yahi rakhna hai : LockID

  attribute {
    name = "LockID"
    type = "S" // S = String
  }

  tags = {
    Name        = "RemoteInfraStateDB"
    Environment = "Dev"
  }
}
