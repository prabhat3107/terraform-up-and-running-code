terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
      #rest of the backend parameters are defined in backend.hcl
      # invoke:  terraform init -backend-config=backend.hcl
      key = "stage/web-server-cluster/terraform.tfstate"
  }    
}

provider "aws" {
    region = "us-east-2"
}

data "terraform_remote_state" "remote_state_db" {
    backend = "s3"
    config = {
        bucket = "pp-billi-tf-state"
        key = "stage/data-stores/terraform.tfstate"
        region = "us-east-2" 
     }
}

resource "aws_instance" "billi_ec2_inst_2" {
    ami                    = "ami-0fb653ca2d3203ac1"
    instance_type          = "t2.micro"
    vpc_security_group_ids = [aws_security_group.instance_sec_group.id]

    user_data = <<-EOF
        #!/bin/bash
        echo "<h1><center>Hello!! Meow World</center></h1>" >> index.html
        echo "<br>" >> index.html
        echo "<h2><b> ${data.terraform_remote_state.remote_state_db.outputs.address}</b></h2>">> index.html
        echo "<h2><b> ${data.terraform_remote_state.remote_state_db.outputs.port}</b></h2>" >> index.html
        nohup busybox httpd -f -p ${var.server_port} &
        EOF
    
}

resource "aws_security_group" "instance_sec_group" {

    name = var.instance_sec_group_name

    ingress {
      cidr_blocks = [ "0.0.0.0/0" ]
      description = "inbound rule for instances "
      from_port = var.server_port
      protocol = "tcp"
      to_port = var.server_port
    } 
  
}
