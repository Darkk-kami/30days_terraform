terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_vpc" "vpc" {
  cidr_block       = var.cidr
  instance_tenancy = "default"
  tags = {
    Name = "${var.tag}-vpc"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.tag}-igw"
  }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "private_subnets" {
  count                   = var.public_subnets_no
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.cidr, 8, count.index)
  availability_zone       = tolist(data.aws_availability_zones.available.names)[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.tag}-private-subent-${count.index}"
  }
}

resource "aws_subnet" "public_subnets" {
  count                   = var.public_subnets_no
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.cidr, 8, count.index + 100)
  availability_zone       = tolist(data.aws_availability_zones.available.names)[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.tag}-public-subent-${count.index}"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "${var.tag}-public-route-table"
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  depends_on     = [aws_subnet.public_subnets]
  route_table_id = aws_route_table.public_route_table.id
  for_each       = { for idx, subnet in aws_subnet.public_subnets : idx => subnet }
  subnet_id      = each.value.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.tag}-private-route-table"
  }
}

resource "aws_route_table_association" "private" {
  depends_on     = [aws_subnet.private_subnets]
  route_table_id = aws_route_table.private_route_table.id
  for_each       = { for idx, subnet in aws_subnet.private_subnets : idx => subnet }
  subnet_id      = each.value.id
}