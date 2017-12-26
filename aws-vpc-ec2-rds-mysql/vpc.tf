
# Example VPC 
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16" 
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "Database VPC"
  }
}

# Internet Gateway to Public Subnets
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.my_vpc.id}"
  tags {
        Name = "Simple Internet Gateway"
    }
}

# Route to Internet Gateway - Public Subnets
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.my_vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}
