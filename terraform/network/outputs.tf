# Export Variable Config: Network

# VPC Config | =============================
output "vpc_id" {
  value = aws_vpc.Amate-VPC.id
}

# Subnet Config | =============================
output "subnet_public_a_id" {
  value = aws_subnet.Amate-Public-A.id
}
output "subnet_private_a_id" {
  value = aws_subnet.Amate-Private-A.id
}

# NAT Config | =============================
output "nat_eip_id" {
  value = aws_eip.Amate-NAT-EIP.id
}
output "nat_gw_id" {
  value = aws_nat_gateway.Amate-NAT-GW.id
}