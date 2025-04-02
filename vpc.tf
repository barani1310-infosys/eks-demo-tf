resource "aws_vpc" "my_VPC" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "VPC"
  }
}

resource "aws_subnet" "my_pubsubnet" {
  vpc_id     = aws_vpc.my_VPC.id
  cidr_block = var.public_subnet_cidr

  tags = {
    Name = "pub_subnet"
  }
}

resource "aws_subnet" "my_pubsubnet_1" {
  vpc_id     = aws_vpc.my_VPC.id
  cidr_block = var.public_subnet_cidr_1

  tags = {
    Name = "pub_subnet_1"
  }
}
resource "aws_subnet" "my_prisubnet" {
  vpc_id     = aws_vpc.my_VPC.id
  cidr_block = var.private_subnet_cidr

  tags = {
    Name = "pri_subnet"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_VPC.id

  tags = {
    Name = "IGW"
  }
}

resource "aws_eip" "my_eip" {
  domain = "vpc"
  # we need to give here instance id  "instance = aws_instance.web.id"
}

resource "aws_nat_gateway" "my_ngw" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = aws_subnet.my_pubsubnet.id

  tags = {
    Name = "gw NAT"
  }

}

resource "aws_route_table" "my_pubrt" {
  vpc_id = aws_vpc.my_VPC.id

  tags = {
    Name = "pub_route_table"
  }
}

resource "aws_route_table" "my_prirt" {
  vpc_id = aws_vpc.my_VPC.id

  tags = {
    Name = "pri_route_table"
  }
}

resource "aws_route_table_association" "pub-rt-a" {
  subnet_id      = aws_subnet.my_pubsubnet.id
  route_table_id = aws_route_table.my_pubrt.id
}