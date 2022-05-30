variable "s3_bucket_name_tf_state" {
    description = "Name of the S3 bucket storing Terraform State"
    type = string
    default = "prjtf-s3-bucket-tf-state"
  
}

variable "dynamodb_table" {

    description = "Name of the dnynamo db table "
    type = string
    default = "proj-tf-state-locks"
  
}