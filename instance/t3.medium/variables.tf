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