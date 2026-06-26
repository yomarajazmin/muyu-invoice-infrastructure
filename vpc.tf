# VPC resources will be defined here when network infrastructure is implemented.
resource "aws_vpc" "muyu" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.prefix_name}-vpc"
  }
}
# Public subnet resources will be added here for internet-facing components.
resource "aws_subnet" "public-subnet-1" {
  vpc_id     = aws_vpc.muyu.id
  cidr_block = var.public_subnet_1_cidr

  tags = {
    Name = "${var.prefix_name}-public-subnet-1"
  }
}
resource "aws_subnet" "public-subnet-2" {
  vpc_id     = aws_vpc.muyu.id
  cidr_block = var.public_subnet_2_cidr

  tags = {
    Name = "${var.prefix_name}-public-subnet-2"
  }
}
# Private subnet resources will be added here for internal components.
resource "aws_subnet" "private-subnet-1" {
  vpc_id     = aws_vpc.muyu.id
  cidr_block = var.private_subnet_1_cidr

  tags = {
    Name = "${var.prefix_name}-private-subnet-1"
  }
}
resource "aws_subnet" "private-subnet-2" {
  vpc_id     = aws_vpc.muyu.id
  cidr_block = var.private_subnet_2_cidr

  tags = {
    Name = "${var.prefix_name}-private-subnet-2"
  }
}
# Internet Gateway resources will be added here for public internet access.
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.muyu.id

  tags = {
    Name = "${var.prefix_name}-igw"
  }
}
# Route Tables will be added here for public and private subnet routing.
resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.muyu.id

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
#   route {
#     cidr_block           = "::/0"
#     egress_only_gateway_id = aws_egress_only_internet_gateway.muyu.id
#   }

  tags = {
    Name = "${var.prefix_name}-rt-public"
  }
}
resource "aws_route_table_association" "rta_public_subnet_1" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.rt_public.id
}
resource "aws_route_table_association" "rta_public_subnet_2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.rt_public.id
}
# Route Table Associations will be added here to attach subnets to routes.
resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.muyu.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }
#   route {
#     cidr_block           = "::/0"
#     egress_only_gateway_id = aws_egress_only_internet_gateway.muyu.id
#   }

  tags = {
    Name = "${var.prefix_name}-rt-private"
  }
}
resource "aws_route_table_association" "rta_private_subnet_1" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.rt_private.id
}
resource "aws_route_table_association" "rta_private_subnet_2" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.rt_private.id
}

# NAT Gateway resources will be added here for private subnet internet access.
resource "aws_eip" "natgw_eip" {
  domain = "vpc"

  tags = {
    Name = "${var.prefix_name}-natgw-eip"
  }
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.natgw_eip.id
  subnet_id     = aws_subnet.public-subnet-1.id

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "${var.prefix_name}-natgw"
  }
}