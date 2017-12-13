
# Public Subnet
resource "aws_subnet" "public_subnet_us_east_1a" {
  vpc_id                  = "${aws_vpc.vpc_elb.id}"
  cidr_block              = "172.31.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
  	Name =  "Public Subnet 1"
  }
}

# NAT Gateway to Public Subnet
resource "aws_nat_gateway" "nat" {
    allocation_id = "${aws_eip.vpc_eip.id}"
    subnet_id = "${aws_subnet.public_subnet_us_east_1a.id}"
    depends_on = ["aws_internet_gateway.gw"]
}

# Associate subnet public_subnet_us_east_1a to public route table
resource "aws_route_table_association" "public_subnet_us_east_1a_association" {
    subnet_id = "${aws_subnet.public_subnet_us_east_1a.id}"
    route_table_id = "${aws_vpc.vpc_elb.main_route_table_id}"
}


