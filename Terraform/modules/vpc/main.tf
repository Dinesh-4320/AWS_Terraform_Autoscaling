resource "aws_vpc" "autoscaling-vpc" {
  cidr_block = var.vpc-cidr
  instance_tenancy = "default"

  tags = {
    Name = "Autoscaling-Project-VPC"
  }
}

resource "aws_subnet" "AS-subnet" {
  count = length(var.subnet-cidrs)
  vpc_id = aws_vpc.autoscaling-vpc.id
  cidr_block = var.subnet-cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = var.subnet-names[count.index]
  }
}

resource "aws_internet_gateway" "AS-ig" {
    vpc_id = aws_vpc.autoscaling-vpc.id
    
    tags = {
        Name = "Autoscaling Internet Gateway"
    }
}

resource "aws_route_table" "AS-rt" {
  vpc_id = aws_vpc.autoscaling-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.AS-ig.id
  }

  tags = {
    Name = "Autoscaling VPC Route table"
  }
}

resource "aws_route_table_association" "AS-rta" {
  count = length(var.subnet-cidrs)
  route_table_id = aws_route_table.AS-rt.id
  subnet_id = aws_subnet.AS-subnet[count.index].id
}