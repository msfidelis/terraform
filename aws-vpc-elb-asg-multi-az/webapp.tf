# EC2 AMI
variable "webapp_ami" {
  description = "Amazon Linux"
  default = "ami-8c1be5f6"
}

# EC2 Type
variable "webapp_instance_type" {
  description = "EC2 instance type"
  default = "t2.micro"
}

# Instances Security Group 
resource "aws_security_group" "webapp_sg" {

    name        = "webapp_sg"
    description = "Security Group for EC2 instances"
    vpc_id      = "${aws_vpc.vpc_elb.id}"

    ingress {
        from_port = 80
        to_port = 80
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

    lifecycle {
        create_before_destroy = true
    }
}

# ELB Security Group 
resource "aws_security_group" "webapp_sg_elb" {

    name        = "webapp_sg_elb"
    description = "ELB Security Group for WebApp"

    vpc_id = "${aws_vpc.vpc_elb.id}"

    # HTTP access from anywhere
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # outbound internet access
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # ensure the VPC has an Internet gateway or this step will fail
    depends_on = ["aws_internet_gateway.gw"]

    lifecycle {
        create_before_destroy = true
    }
}

# Webapp Elastic Load Balancer
resource "aws_elb" "webapp_elb" {

    name = "webapp"

    # Public Subnets. The same availability zone as our instance.
    subnets = [
        "${aws_subnet.public_subnet_us_east_1a.id}", 
        "${aws_subnet.public_subnet_us_east_1b.id}",
        "${aws_subnet.public_subnet_us_east_1c.id}"
        ]

    security_groups = ["${aws_security_group.webapp_sg_elb.id}"]

    # HTTP Listener on port 80 to port 80
    listener {
        lb_port           = 80
        lb_protocol       = "http"
        instance_port     = 80
        instance_protocol = "http"
    }
 
    # ELB Instance http healthcheck
    health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 10
        target              = "HTTP:80/"
        interval            = 30
    }

    # The instance is registered automatically
    cross_zone_load_balancing   = true
    idle_timeout                = 400
    connection_draining         = true
    connection_draining_timeout = 400
}


# Launch Configuration 
resource "aws_launch_configuration" "webapp_lcfg" {

    image_id=  "${var.webapp_ami}"
    instance_type = "${var.webapp_instance_type}"
    security_groups = ["${aws_security_group.webapp_sg.id}"]
    key_name = "${aws_key_pair.vpc_terraform_key.key_name}"

    user_data = "${file("user-data/bootstrap.sh")}"

    lifecycle {
        create_before_destroy = true
    }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "webapp_scalegroup" {

    launch_configuration = "${aws_launch_configuration.webapp_lcfg.name}"

    # Launch on Multi-AZ
    vpc_zone_identifier  = [
        "${aws_subnet.public_subnet_us_east_1a.id}", 
        "${aws_subnet.public_subnet_us_east_1b.id}",
        "${aws_subnet.public_subnet_us_east_1c.id}"
        ]

    min_size = 3
    max_size = 10

    enabled_metrics = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupTotalInstances"]
    metrics_granularity="1Minute"
    load_balancers= ["${aws_elb.webapp_elb.id}"]
    
    health_check_type="ELB"

    tag {
        key = "Name"
        value = "webapp_scalegroup"
        propagate_at_launch = true
    }

}

# Auto Scaling Policy UP + 2
resource "aws_autoscaling_policy" "autopolicy-up" {
    name = "terraform-autoplicy"
    scaling_adjustment = 2
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = "${aws_autoscaling_group.webapp_scalegroup.name}"
}

# Cloud Watch Metric Alarm - CPU High
resource "aws_cloudwatch_metric_alarm" "cpualarm" {
    alarm_name = "terraform-alarm"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "120"
    statistic = "Average"
    threshold = "60"

    dimensions {
        AutoScalingGroupName = "${aws_autoscaling_group.webapp_scalegroup.name}"
    }

    alarm_description = "This metric monitor EC2 instance cpu utilization"
    alarm_actions = ["${aws_autoscaling_policy.autopolicy-up.arn}"]
}

# Auto Scaling Policy Down -1  
resource "aws_autoscaling_policy" "autopolicy-down" {
    name = "terraform-autoplicy-down"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = "${aws_autoscaling_group.webapp_scalegroup.name}"
}

# Cloud Watch Metric Alarm - CPU Low
resource "aws_cloudwatch_metric_alarm" "cpualarm-down" {
    alarm_name = "terraform-alarm-down"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "120"
    statistic = "Average"
    threshold = "10"

    dimensions {
        AutoScalingGroupName = "${aws_autoscaling_group.webapp_scalegroup.name}"
    }

    alarm_description = "This metric monitor EC2 instance cpu utilization"
    alarm_actions = ["${aws_autoscaling_policy.autopolicy-down.arn}"]
}