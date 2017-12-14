
# Example VPC
resource "aws_vpc" "vpc_elb" {
  cidr_block = "172.31.0.0/16" 
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "VPC do Raj"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc_elb.id}"
  tags {
        Name = "InternetGateway"
    }
}

# Route to Internet Gateway
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.vpc_elb.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}

# Elastic IP
resource "aws_eip" "vpc_eip" {
  vpc      = true
  depends_on = ["aws_internet_gateway.gw"]
}

