# Private Subnet 1
resource "aws_subnet" "private_subnet_1_us_east_1a" {
  vpc_id                  = "${aws_vpc.my_vpc.id}"
  cidr_block              = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
  	Name =  "Private Subnet 1"
  }
}

# Private Subnet 2
resource "aws_subnet" "private_subnet_2_us_east_1b" {
  vpc_id                  = "${aws_vpc.my_vpc.id}"
  cidr_block              = "10.0.3.0/24"
  availability_zone = "us-east-1b"
  tags = {
  	Name =  "Private Subnet 2"
  }
}

# Private Subnet 2
resource "aws_subnet" "private_subnet_3_us_east_1c" {
  vpc_id                  = "${aws_vpc.my_vpc.id}"
  cidr_block              = "10.0.4.0/24"
  availability_zone = "us-east-1c"
  tags = {
  	Name =  "Private Subnet 3"
  }
}