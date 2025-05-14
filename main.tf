# main.tf: Terraform 메인 flow 설정

# 0. Provider 설정 | =================================================
provider "aws" {
  region = "ap-northeast-2"
}

# 1. 네트워크 설정 | =================================================
module "network" {
  source = "./network"
}

output "vpc_id" {
  value = module.network.vpc_id
}
output "subnet_public_a_id" {
  value = module.network.subnet_public_a_id
}
output "subnet_private_a_id" {
  value = module.network.subnet_private_a_id
}
output "nat_eip_id" {
  value = module.network.nat_eip_id
}
output "nat_gw_id" {
  value = module.network.nat_gw_id
}

# =================================================================