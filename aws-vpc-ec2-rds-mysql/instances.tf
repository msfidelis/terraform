# EC2 AMI
variable "example_ami" {
  description = "Amazon Linux"
  default = "ami-8c1be5f6"
}

# EC2 Type
variable "example_instance_type" {
  description = "EC2 instance type"
  default = "t2.micro"
}

# Instances Security Group 
resource "aws_security_group" "example_sg" {

    name        = "example_sg"
    description = "Security Group for EC2 instances"

    vpc_id      = "${aws_vpc.my_vpc.id}"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }    

    egress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_instance" "node" {

    ami = "${var.example_ami}"
    instance_type = "${var.example_instance_type}"
    key_name = "${aws_key_pair.vpc_dbs_key.key_name}"
    vpc_security_group_ids = ["${aws_security_group.example_sg.id}"] 
    
    subnet_id = "${aws_subnet.public_subnet_us_east_1a.id}"

    tags {
        Name = "Simple Node"
    }

}
