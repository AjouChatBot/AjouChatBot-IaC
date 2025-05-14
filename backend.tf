# backend.tf: Terraform의 AWS 적용상태 (state)를 저장할 저장소 지정

terraform {
  backend "local" {
    path = "backend/terraform.tfstate"
  }
}