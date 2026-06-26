# Useful identifiers printed after terraform apply.
output "vpc_id" {
  value = aws_vpc.muyu.id
}

output "public_subnet1_id" {
  value = aws_subnet.public-subnet-1.id
}

output "public_subnet2_id" {
  value = aws_subnet.public-subnet-2.id
}

output "private_subnet1_id" {
  value = aws_subnet.private-subnet-1.id
}

output "private_subnet2_id" {
  value = aws_subnet.private-subnet-2.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.natgw.id
}

output "nat_public_ip" {
  value = aws_eip.natgw_eip.public_ip
}