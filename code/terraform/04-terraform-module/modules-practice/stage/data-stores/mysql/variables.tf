# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "db_username" {
  description = "The username for the database"
  type        = string
  sensitive   = true
  default = "billi"
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
  default = "billi123"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "db_name" {
  description = "The name to use for the database"
  type        = string
  default     = "mysql_database_stage"
}

variable "db_id_prefix" {

    description = "The DB Identifier prefix"
    type = string
    default = "stage"

}

variable "db_instance_class" {

    description = "The Name of the DB instance class"
    type = string
    default = "db.t2.micro"
}


variable "db_s3_state_bucket" {
  description = "The name of the S3 bucket used for the database's remote state storage"
  type        = string
  default = "prjtf-s3-bucket-tf-state"
}

variable "db_s3_state_key" {
  description = "The name of the key in the S3 bucket used for the database's remote state storage"
  type        = string
  default = "stage/data-stores/mysql/terraform.tfstate"
}


variable "db_s3_dynamodb_table" {

    description = "Name of the dnynamo db table "
    type = string
    default = "proj-tf-state-locks"
  
}