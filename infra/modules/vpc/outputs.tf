output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "private_subnet1" {
  value = aws_subnet.private_subnet1.id
}

output "private_subnet2" {
  value = aws_subnet.private_subnet2.id
}

output "public_subnet1" {
  value = aws_subnet.public_subnet1.id
}

output "public_subnet2" {
  value = aws_subnet.public_subnet2.id
}