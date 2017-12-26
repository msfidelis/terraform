# Public Subnet on us-east-1a
resource "aws_subnet" "public_subnet_us_east_1a" {
  vpc_id                  = "${aws_vpc.my_vpc.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
  	Name =  "Public Subnet 1"
  }
}

# Associate subnet public_subnet_us_east_1a to public route table
resource "aws_route_table_association" "public_subnet_us_east_1a_association" {
    subnet_id = "${aws_subnet.public_subnet_us_east_1a.id}"
    route_table_id = "${aws_vpc.my_vpc.main_route_table_id}"
}