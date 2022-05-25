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
      key = "example/terraform.tfstate"
  }
}