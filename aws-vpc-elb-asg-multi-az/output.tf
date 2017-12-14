# ELB DNS Hostname
output "elb_hostname" {
  value = "${aws_vpc.vpc_elb.dns_name}"
}