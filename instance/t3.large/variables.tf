# Input Variable Config

variable "instance_name" {
  type = string
  description = "EC2 인스턴스 이름"
}

variable "subnet_id" {
  type = string
  description = "EC2 연결 서브넷"
}

variable "security_group_id" {
  type = string
  description = "EC2 적용 보안그룹"
}

variable "key_name" {
  type = string
  description = "접속 ECDSA 키 이름"
}

variable "auto_public_ip" {
  type = bool
  description = "공인ip 자동할당여부"
  default = false
}

variable "init_script" {
  type = string
  description = "최초설정 시 실행할 명령스크립트"
  default = "./scripts/t3.large.sh"
}