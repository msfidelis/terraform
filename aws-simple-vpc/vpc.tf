resource "aws_vpc" "vpc_terraform" {
  cidr_block = "172.31.0.0/16" 
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "VPC do Raj"
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet_us_east_1a" {
  vpc_id                  = "${aws_vpc.vpc_terraform.id}"
  cidr_block              = "172.31.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
  	Name =  "Public Subnet 1"
  }
}

# Private Subnet 1
resource "aws_subnet" "private_1_subnet_us_east_1a" {
  vpc_id                  = "${aws_vpc.vpc_terraform.id}"
  cidr_block              = "172.31.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
  	Name =  "Private Subnet 1"
  }
}

# Private Subnet 2 
resource "aws_subnet" "private_2_subnet_us_east_1b" {
  vpc_id                  = "${aws_vpc.vpc_terraform.id}"
  cidr_block              = "172.31.3.0/24"
  availability_zone = "us-east-1b"
  tags = {
  	Name =  "Private Subnet 2"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc_terraform.id}"
  tags {
        Name = "InternetGateway"
    }
}

# Route to Internet Gateway
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.vpc_terraform.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}

# Elastic IP
resource "aws_eip" "vpc_eip" {
  vpc      = true
  depends_on = ["aws_internet_gateway.gw"]
}

# NAT Gateway to Public Subnet
resource "aws_nat_gateway" "nat" {
    allocation_id = "${aws_eip.vpc_eip.id}"
    subnet_id = "${aws_subnet.public_subnet_us_east_1a.id}"
    depends_on = ["aws_internet_gateway.gw"]
}

# Route Table to Private Subnet
resource "aws_route_table" "private_route_table" {
    vpc_id = "${aws_vpc.vpc_terraform.id}"
 
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

# Associate subnet public_subnet_us_east_1a to public route table
resource "aws_route_table_association" "public_subnet_us_east_1a_association" {
    subnet_id = "${aws_subnet.public_subnet_us_east_1a.id}"
    route_table_id = "${aws_vpc.vpc_terraform.main_route_table_id}"
}
 
# Associate subnet private_1_subnet_us_east_1a to private route table
resource "aws_route_table_association" "pr_1_subnet_us_east_1a_association" {
    subnet_id = "${aws_subnet.private_1_subnet_us_east_1a.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}
 
# Associate subnet private_2_subnet_us_east_1b to private route table
resource "aws_route_table_association" "pr_2_subnet_us_east_1b_association" {
    subnet_id = "${aws_subnet.private_2_subnet_us_east_1b.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}