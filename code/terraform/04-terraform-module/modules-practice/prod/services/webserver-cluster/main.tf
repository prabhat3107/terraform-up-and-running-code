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
        key = "prod/services/webserver-cluster/terraform.tfstate"        
      
    }
}

provider "aws" {

    region = "us-east-2"
  
}

module "webserver_cluster" {

    source = "../../../modules/services/webserver-cluster"

    cluster_name = var.cluster_name
    db_remote_state_bucket = var.db_remote_state_bucket
    db_remote_state_key = var.db_remote_state_key
    environment = var.environment

    instance_type = "t2.micro"

    min_size = 2
    max_size = 10
}

resource "aws_security_group_rule" "allow_testing_inbound" {

    type = "ingress"
    security_group_id = module.webserver_cluster.alb_security_group_id

    from_port = 12345
    to_port = 12345
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

}