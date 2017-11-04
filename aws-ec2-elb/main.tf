provider "aws" {
  region = "${var.region}" 
}

##Security Group Config
resource "aws_security_group" "default" {
  name = "ec2-elb-sg"

  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


## Default key pair. Edit this on variables.tf file
resource "aws_key_pair" "default" {
  key_name = "ec2-elb-key"
  public_key = "${file("${var.key_path}")}"
}

## EC2 Instance 1
resource "aws_instance" "webserver001" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.default.id}"
  security_groups = ["${aws_security_group.default.name}"]
  user_data = "${file("user-data/webserver001.sh")}"

  tags {
    Name = "webserver001"
  }
}

resource "aws_instance" "webserver002" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.default.id}"
  security_groups = ["${aws_security_group.default.name}"]
  user_data = "${file("user-data/webserver002.sh")}"

  tags {
    Name = "webserver002"
  }
}

## Load Balancer Config
resource "aws_elb" "default" {
  name = "ec2-elb"
  ## Register instances
  instances = ["${aws_instance.webserver001.id}", "${aws_instance.webserver002.id}"]
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  
  ## Listener Ports
  listener {
    instance_port = 80
    instance_protocol = "tcp"
    lb_port = 80
    lb_protocol = "tcp"
  }
  
  ## Health Check Configs
  health_check {
    target = "HTTP:80/"
    healthy_threshold = 2
    unhealthy_threshold = 2
    interval = 30
    timeout = 5
  }

  tags {
    Name = "ec2-elb"
  }
}
