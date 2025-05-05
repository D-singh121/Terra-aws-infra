resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name         = "RemoteInfraStateDB"
  billing_mode = "PAY_PER_REQUEST" // On-demand mode
  hash_key     = "Lock_ID"

  attribute {
    name = "Lock_ID"
    type = "S"  // S = String
  }

  tags = {
    Name        = "RemoteInfraStateDB"
    Environment = "Dev"
  }
}
