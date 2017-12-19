
# Public Subnet on us-east-1a
resource "aws_subnet" "public_subnet_us_east_1a" {
  vpc_id                  = "${aws_vpc.vpc_elb.id}"
  cidr_block              = "172.31.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
  	Name =  "Public Subnet 1"
  }
}

# Associate subnet public_subnet_us_east_1a to public route table
resource "aws_route_table_association" "public_subnet_us_east_1a_association" {
    subnet_id = "${aws_subnet.public_subnet_us_east_1a.id}"
    route_table_id = "${aws_vpc.vpc_elb.main_route_table_id}"
}

# Public Subnet 2 on us-east-1b
resource "aws_subnet" "public_subnet_us_east_1b" {
  vpc_id                  = "${aws_vpc.vpc_elb.id}"
  cidr_block              = "172.31.3.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"
  tags = {
  	Name =  "Public Subnet 2"
  }
}

# Associate subnet public_subnet_us_east_1b to public route table
resource "aws_route_table_association" "public_subnet_us_east_1b_association" {
    subnet_id = "${aws_subnet.public_subnet_us_east_1b.id}"
    route_table_id = "${aws_vpc.vpc_elb.main_route_table_id}"
}

# Public Subnet 3 on us-east-1c
resource "aws_subnet" "public_subnet_us_east_1c" {
  vpc_id                  = "${aws_vpc.vpc_elb.id}"
  cidr_block              = "172.31.4.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1c"
  tags = {
  	Name =  "Public Subnet 3"
  }
}

# Associate subnet public_subnet_us_east_1b to public route table
resource "aws_route_table_association" "public_subnet_us_east_1c_association" {
    subnet_id = "${aws_subnet.public_subnet_us_east_1c.id}"
    route_table_id = "${aws_vpc.vpc_elb.main_route_table_id}"
}

