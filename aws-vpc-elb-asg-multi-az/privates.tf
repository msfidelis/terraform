# Route Table to Private Subnet
resource "aws_route_table" "private_route_table" {
    vpc_id = "${aws_vpc.vpc_elb.id}"
 
    tags {
        Name = "Private Route Table"
    }
}

# Private Route to Internet 
resource "aws_route" "private_route" {
	route_table_id  = "${aws_route_table.private_route_table.id}"
	destination_cidr_block = "0.0.0.0/0"
	nat_gateway_id = "${aws_nat_gateway.nat.id}"
}

# Private Subnet 1
resource "aws_subnet" "private_1_subnet_us_east_1a" {
  vpc_id                  = "${aws_vpc.vpc_elb.id}"
  cidr_block              = "172.31.4.0/24"
  availability_zone = "us-east-1a"
  tags = {
  	Name =  "Private Subnet 1"
  }
}

# Associate subnet private_1_subnet_us_east_1a to private route table
resource "aws_route_table_association" "pr_1_subnet_us_east_1a_association" {
    subnet_id = "${aws_subnet.private_1_subnet_us_east_1a.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}

# Private Subnet 2
resource "aws_subnet" "private_2_subnet_us_east_1b" {
  vpc_id                  = "${aws_vpc.vpc_elb.id}"
  cidr_block              = "172.31.5.0/24"
  availability_zone = "us-east-1b"
  tags = {
  	Name =  "Private Subnet 2"
  }
}

# Associate subnet private_2_subnet_us_east_1a to private route table
resource "aws_route_table_association" "pr_2_subnet_us_east_1b_association" {
    subnet_id = "${aws_subnet.private_2_subnet_us_east_1b.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}

# Private Subnet 3
resource "aws_subnet" "private_3_subnet_us_east_1c" {
  vpc_id                  = "${aws_vpc.vpc_elb.id}"
  cidr_block              = "172.31.6.0/24"
  availability_zone = "us-east-1c"
  tags = {
  	Name =  "Private Subnet 3"
  }
}

# Associate subnet private_3_subnet_us_east_1c to private route table
resource "aws_route_table_association" "pr_3_subnet_us_east_1c_association" {
    subnet_id = "${aws_subnet.private_3_subnet_us_east_1c.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}


# Private Databases Subnet 1
resource "aws_subnet" "private_database_subnet_1_us_east_1a" {
  vpc_id                  = "${aws_vpc.vpc_elb.id}"
  cidr_block              = "172.31.7.0/24"
  availability_zone = "us-east-1a"
  tags = {
  	Name =  "Private Databases Subnet 1"
  }
}

# Associate subnet private_database_subnet_1_us_east_1a to private route table
resource "aws_route_table_association" "pr_database_subnet_1_us_east_1a_association" {
    subnet_id = "${aws_subnet.private_database_subnet_1_us_east_1a.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}

# Private Databases Subnet 2
resource "aws_subnet" "private_database_subnet_2_us_east_1b" {
  vpc_id                  = "${aws_vpc.vpc_elb.id}"
  cidr_block              = "172.31.8.0/24"
  availability_zone = "us-east-1b"
  tags = {
  	Name =  "Private Databases Subnet 2"
  }
}

# Associate subnet private_database_subnet_2_us_east_1b to private route table
resource "aws_route_table_association" "pr_database_subnet_2_us_east_1b_association" {
    subnet_id = "${aws_subnet.private_database_subnet_2_us_east_1b.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}