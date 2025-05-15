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

## Public VPC - Bastion Instance | -------------------------------
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
  auto_public_ip = true
}

## Private VPC - K8s Master Instance | --------------------------
module "k8s_sg" {
  source = "./security/k8s"
  vpc_id = module.network.vpc_id
}
module "k8s_master_sgr" {
  source = "./security/k8s/master_rule"
  master_sgid = module.k8s_sg.master_sgid
  worker_sgid = module.k8s_sg.worker_sgid
  ssh_allow_sgid = module.bastion_sg.sgid
}
module "k8s_worker_sgr" {
  source = "./security/k8s/worker_rule"
  master_sgid = module.k8s_sg.master_sgid
  worker_sgid = module.k8s_sg.worker_sgid
  ssh_allow_sgid = module.bastion_sg.sgid
}

module "k8s_master" {
  source = "./instance/t3.medium"
  instance_name = "K8s Master"
  subnet_id = module.network.subnet_private_a_id
  security_group_id = module.k8s_sg.master_sgid
  key_name = module.key.Amate-key.key_name
}

module "k8s_worker_1" {
  source = "./instance/t3.medium"
  instance_name = "K8s Worker 1"
  subnet_id = module.network.subnet_private_a_id
  security_group_id = module.k8s_sg.worker_sgid
  key_name = module.key.Amate-key.key_name
}