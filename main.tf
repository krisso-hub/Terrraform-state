provider "aws" {
    profile = "default"
    region  = "us-east-1"
}

resource "aws_s3_bucket" "backend-tf" {
  bucket = "my-backend-11192021"
  acl    = "private"

#Enable versioning
    versioning {
    enabled = true
  }

  #Enable server side encreption
    server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }

  tags = {
    Name        = "My backend-bucket"
    Environment = "Dev"
  }
}

resource "aws_dynamodb_table" "dynamo-lock" {
  name             = "tf-db-lock"
  hash_key         = "LockID"
  billing_mode     = "PAY_PER_REQUEST"
  

  attribute {
    name = "LockID"
    type = "S"
  }
}