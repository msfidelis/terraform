provider "aws" {
    region = "${var.aws_region}"
}

resource "aws_key_pair" "vpc_dbs_key" {
  key_name = "vpc-dbs-key"
  public_key = "${file("${var.aws_key_path}")}"
}