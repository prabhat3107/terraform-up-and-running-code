terraform {
    required_version = ">= 1.0.0, < 2.0.0"

    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.0"
        }
    }

    backend "s3" {

      #rest of the backend parameters are defined in backend.hcl
      # invoke:  terraform init -backend-config=backend.hcl
        key = "stage/data-stores/mysql/terraform.tfstate"
      
    }
}


provider "aws" {

    region = "us-east-2"
  
}

resource "aws_db_instance" "dbi" {

    identifier_prefix = var.db_id_prefix
    engine = "mysql"
    allocated_storage = 10
    instance_class = var.db_instance_class
    db_name = var.db_name
    username = var.db_username
    password = var.db_password
    skip_final_snapshot = true
  
}

