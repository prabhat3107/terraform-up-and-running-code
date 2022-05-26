output "public_ip" {
  value       = aws_instance.billi_ec2_inst_2.public_ip
  description = "The public IP of the Instance"
}
