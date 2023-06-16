output "public_subnet_id_1" {
  value = aws_subnet.public_subnet01.id
}
output "public_subnet_id_2" {
  value = aws_subnet.public_subnet02.id
}
output "sg_id_1" {
  value = aws_security_group.sg01.id
}
output "sg_id_2" {
  value = aws_security_group.sg02.id
}
output "vpc_id" {
  value = aws_vpc.vpc01.id
}