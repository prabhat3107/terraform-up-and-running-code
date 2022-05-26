terraform {
  required_version = ">= 1.0.0 , < 2.0.0"
  required_providers {
      aws = {
          source = "hashicorp/aws"
          version = "~> 4.0"
      }
  }
  
  backend "s3" {
      #rest of the backend parameters are defined in backend.hcl
      # invoke:  terraform init -backend-config=backend.hcl
      key = "stage/data-stores/terraform.tfstate"
  }
}
provider "aws" {

    region = "us-east-2"
  
}
resource "aws_db_instance" "billi_db" {

    identifier_prefix = "tf-up-and-running-practice"
    engine = "mysql"
    allocated_storage = 10
    instance_class = "db.t2.micro"
    skip_final_snapshot = true
    db_name = "billi_database"
    
    username = var.db_username
    password = var.db_password
}


