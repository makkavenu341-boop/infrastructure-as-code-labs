resource "aws_vpc" "vpc1" {
    cidr_block = var.infra.vpc_cidr
    tags = {
      Name = var.infra.vpc_name
    }
  }

 resource "aws_subnet" "arb_subnet" {
    vpc_id = aws_vpc.vpc1.id
    count = length(var.infra.sub_info.sub_az)
    cidr_block = var.infra.sub_info.sub_cidr[count.index]
    availability_zone = var.infra.sub_info.sub_az[count.index]
    tags = {
      Name = var.infra.sub_info.sub_name[count.index]
    }
   
 }
 resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc1.id
    tags = {
      Name = "my-igw1"
    }
   
 }
 resource "aws_route_table" "rt1"{
    vpc_id = aws_vpc.vpc1.id
    count = 3
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name = "my-rt1-${count.index + 1}"
    }
   
 }
 resource "aws_route_table_association" "association" {
    count = 3
    route_table_id = aws_route_table.rt1[count.index].id
    subnet_id = aws_subnet.arb_subnet[count.index].id
   
 }

 resource "aws_security_group" "sg-vpc1" {
  vpc_id = aws_vpc.vpc1.id
  count = 3
  description = "allowing ssh and http types in inbound and all traffic in outbound"
  name = "sg_vpc1-${count.index + 1}"
   
 
 #ssh
 ingress {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }
 #https
 ingress {
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

 }
 #allowing all traffic
 egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
    
    }
 }
 