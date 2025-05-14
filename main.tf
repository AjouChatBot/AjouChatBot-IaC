# main.tf: Terraform 메인 flow 설정

# 0. Provider 설정 | =================================================
provider "aws" {
  region = "ap-northeast-2"
}

# 1. 네트워크 설정 | =================================================
module "network" {
  source = "./network"
}

# 2. 인스턴스 설정 | =================================================

module "key" {
  source = "./key"
}

module "bastion_sg" {
  source = "./security/bastion"
  vpc_id = module.network.vpc_id
}

module "bastion" {
  source = "./instance/t2.micro"
  instance_name = "Bastion Instance"
  subnet_id = module.network.subnet_public_a_id
  security_group_id = module.bastion_sg.sgid
  key_name = module.key.Amate-key.key_name
}