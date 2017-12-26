
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

## Security Group 
resource "aws_security_group" "rds_mysql" {

    name = "rdsSG"
    description = "RDS security group"
    vpc_id = "${aws_vpc.my_vpc.id}"

    ingress {
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      security_groups = ["${aws_security_group.example_sg.id}"]
   }
}


## Simple MySQL RDS Instance
resource "aws_db_instance" "my_db" {
    identifier            = "mydatabase"
    allocated_storage     = 100
    storage_type          = "io1" 
    iops                  = 1000
    engine                = "mysql"
    engine_version        = "5.7.19"
    instance_class        = "db.t2.small"
    multi_az              = "false"
    name                  = "mydb"
    username              = "root"
    password              = "123456789"
    final_snapshot_identifier = "snap-logo-final-snapshot-${md5(timestamp())}"
    copy_tags_to_snapshot = "false"
    skip_final_snapshot   = "true"   
    db_subnet_group_name  = "${aws_db_subnet_group.private_dbs.id}"
    vpc_security_group_ids = ["${aws_security_group.rds_mysql.id}"]
    parameter_group_name  = "default.mysql5.7"
  
}