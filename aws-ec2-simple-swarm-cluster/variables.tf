variable "region" {
  description = "AWS Region"
  default = "us-east-1"
}

variable "key_path" {
  description = "Public key path"
  default = "/Users/matheus/.ssh/id_rsa.pub"
}

variable "ami" {
  description = "AMI"
  default = "ami-8c1be5f6" // Amazon Linux
}

variable "instance_type" {
  description = "EC2 instance type"
  default = "t2.micro"
}
