terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.0"
    }
  }

}

provider "aws" {

    region = "us-east-2"
  
}

#Creaet S3 bucket to store Terraform State
resource "aws_s3_bucket" "s3_bucket_tf_state" {

    bucket = var.s3_bucket_name_tf_state

    #prevent accicental destruction. 
    lifecycle {
      prevent_destroy = true
    }
  
}

#enable versioning so you can see full revision history of your state file
resource "aws_s3_bucket_versioning" "enabled" {
    bucket = aws_s3_bucket.s3_bucket_tf_state.id

    versioning_configuration {
      status = "Enabled"
    }
  
}

#enable server side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket_serverside_encription_config" {
    bucket = aws_s3_bucket.s3_bucket_tf_state.id

    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}


#block public access ot the S3 bucket 
resource "aws_s3_bucket_public_access_block" "public_access" {

    bucket = aws_s3_bucket.s3_bucket_tf_state.id

    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true 

}

#create dynamodb
resource "aws_dynamodb_table" "terraform_locks" {

    name = var.dynamodb_table
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"

    attribute {
      name = "LockID"
      type = "S"
    }
  
}