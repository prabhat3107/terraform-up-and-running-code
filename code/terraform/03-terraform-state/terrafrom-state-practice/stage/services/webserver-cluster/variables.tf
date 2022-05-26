variable "server_port" {

    description = "Web server's listening port"
    type = number
    default = 8080
  
}

variable "instance_sec_group_name" {

    description = "Name of the instance security group"
    type = string
    default = "billi-inst-sec-grp"
  
}