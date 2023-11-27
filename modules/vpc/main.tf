# creating vpc
resource "aws_vpc" "prd-aws-1" {
  cidr_block              = var.vpc_cidr
  instance_tenancy        = default
  enable_dns_hostnames    = true

  tags      = {
    Name    = "${var.aws-project}-vpc"
  }
}

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "aws-prd-igw" {
  vpc_id    = aws_vpc.prd-aws-1.id  

  tags      = {
    Name    = "${var.aws-project}-igw"
  }
}

# use data source to get all avalablility zones in region
data "aws_availability_zones" "prd-aws-az1" {}

# create public subnet az1
resource "aws_subnet" "aws-prd-public-subnet-1" {
  vpc_id                  = aws_vpc.prd-aws-1
  cidr_block              = var.public-subnet-az1-cidr
  availability_zone       = data.aws_availability_zones.prd-aws-az1.names[0]
  map_public_ip_on_launch = true

  tags      = {
    Name    = "public subnet az1"
  }
}


# create route table and add public route
resource "aws_route_table" "aws-prd-route-table" {
  vpc_id       = aws_vpc.prd-aws-1.id 

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws-prd-igw.id 
  }

  tags       = {
    Name     = "public route tables"
  }
}

# associate public subnet az1 to "public route table"
resource "aws_route_table_association" "public-aws-prd-rt-associate" {
  subnet_id           = aws_subnet.public-subnet-az1.id 
  route_table_id      = aws_route_table.aws-prd-route-table.id 
}


# create private app subnet az1
resource "aws_subnet" "aws-pvt-app-subnet-1" {
  vpc_id                   = aws_vpc.prd-aws-1.id 
  cidr_block               = var.aws-prd-pvt-subnet-1-cidr
  availability_zone        = data.aws_availability_zones.prd-aws-az1.names[0]
  map_public_ip_on_launch  = false 

  tags      = {
    Name    = "provate subnet app az1"
  }
}

# create private data subnet az1
resource "aws_subnet" "private_data_subnet_az1" {
  vpc_id                   = aws_vpc.prd-aws-1.id 
  cidr_block               = var.aws-prd-pvt-subnet-1-cidr
  availability_zone        = data.aws_availability_zones.prd-aws-az1.names[0]
  map_public_ip_on_launch  = falee

  tags      = {
    Name    = "private subnet for az1"
  }
}

