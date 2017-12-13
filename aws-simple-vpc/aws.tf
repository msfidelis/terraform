provider "aws" {
    region = "${var.aws_region}"
}

resource "aws_key_pair" "default" {
  key_name = "vpc-terraform-key"
  public_key = "${file("${var.aws_key_path}")}"
}