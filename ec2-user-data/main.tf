provider "aws" {
   region = "us-east-1"
}

resource "aws_key_pair" "sshkey" {
   key_name = "sshkey"
   public_key = "${file("/User/matheus/.ssh/id_rsa.pub")}"
}

resource "aws_instance" "node1" {
   ami = "ami-a4c7edb2"
   instance_type = "t2.micro"
   key_name = "sshkey"

   tags {
     Name = "simple"
   }
}
