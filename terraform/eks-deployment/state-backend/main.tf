# S3 bucket for storing state files
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.state_bucket_name

  lifecycle {
    prevent_destroy = true
  }
}


# DynamoDB table for state locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.locks_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
