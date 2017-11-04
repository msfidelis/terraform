provider "aws" {
   region = "us-east-1"
}

resource "aws_key_pair" "sshkey" {
   key_name = "sshkey"
   public_key = "${file("/Users/matheus/.ssh/id_rsa.pub")}"
}

resource "aws_security_group" "jenkins" {
  name = "ec2-jenkins-sg"

  ingress {
    from_port = 8000
    to_port = 8000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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

}

resource "aws_instance" "jenkins" {
   ami = "ami-a4c7edb2"
   instance_type = "t2.micro"
   key_name = "sshkey"
   security_groups = ["${aws_security_group.jenkins.name}"]
   user_data = "${file("bootstrap.sh")}"
   tags {
     Name = "jenkins"
   }
}
