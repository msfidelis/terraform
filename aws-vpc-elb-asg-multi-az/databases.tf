// resource "aws_db_instance" "mydb" {
//     identifier              = "testdb-rds"      
//     allocated_storage       = 10
//     //storage_type            = "gp2"
//     engine                  = "mysql"
//     engine_version          = "5.7.19"
//     instance_class          = "db.t2.small"
//     availability_zone       = "us-east-1a"
//     name                    = "mydb"
//     username                = "foo"
//     password                = "1234567891011"
//     db_subnet_group_name    = "${aws_subnet.private_1_subnet_us_east_1a.id}"
//     //Webapp Security Group
//     vpc_security_group_ids  = ["${aws_security_group.webapp_sg.id}"] 
//     parameter_group_name    = "default.mysql5.6"
// }


resource "aws_db_subnet_group" "private_dbs" {
  name       = "private-dbs"
  subnet_ids = ["${aws_subnet.private_database_subnet_1_us_east_1a.id}", "${aws_subnet.private_database_subnet_2_us_east_1b.id}"]

  tags {
    Name = "Databases Subnet"
  }
}