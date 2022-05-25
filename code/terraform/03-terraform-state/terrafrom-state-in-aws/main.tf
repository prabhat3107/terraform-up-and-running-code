terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
      aws = {
          source = "hashicorp/aws"
          version = "~> 4.0"
      }
  }

  backend "s3" {
    bucket = "pp-billi-tf-state"
    key = "global/s3/terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "tf-state-locks"
    encrypt = true
  }

}

provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "terraform_state" {

    bucket = "pp-billi-tf-state"

    lifecycle {
      prevent_destroy = true
    }
}

resource "aws_s3_bucket_versioning" "enabled" {
    bucket = aws_s3_bucket.terraform_state.id
    versioning_configuration {
      status = "Enabled"
    }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
    bucket = aws_s3_bucket.terraform_state.id
    rule {
      apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
      }
    }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
    bucket = aws_s3_bucket.terraform_state.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true

}

resource "aws_dynamodb_table" "terrarom_locks" {

  name = "tf-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  
  attribute {
    name = "LockID"
    type = "S"
  }
}

