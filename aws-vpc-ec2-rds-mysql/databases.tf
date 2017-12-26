
## Private Subnet Group
resource "aws_db_subnet_group" "private_dbs" {
    name                = "private-dbs"
    ## Multi-AZ Subnet
    subnet_ids = [
      "${aws_subnet.private_subnet_1_us_east_1a.id}", 
      "${aws_subnet.private_subnet_2_us_east_1b.id}",
      "${aws_subnet.private_subnet_3_us_east_1c.id}"
    ]

    tags {
      Name              = "Databases Subnet"
    }

}

## Simple MySQL RDS Instance
resource "aws_db_instance" "my_db" {
    allocated_storage    = 10
    storage_type         = "io1" 
    engine               = "mysql"
    engine_version       = "5.7.19"
    instance_class       = "db.t2.small"
    name                 = "mydb"
    username             = "root"
    password             = "123456789"
    db_subnet_group_name = "${aws_db_subnet_group.private_dbs.id}"
    parameter_group_name = "default.mysql5.7"
}