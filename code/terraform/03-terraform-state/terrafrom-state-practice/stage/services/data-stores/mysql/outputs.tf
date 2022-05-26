output "address" {
    value = aws_db_instance.billi_db.address
    description = "Connect to the DB at this endpoint"
}

output "port" {

    value = aws_db_instance.billi_db.port
    description = "The port the db is listening on"
  
}