# Security Group Config Module: K8sMaster

# Input Variable Config

variable "vpc_id" {
  type = string
  description = "VPC 이름"
}

# Security Group Config

resource "aws_security_group" "Amate-SG-K8s-Master" {
  vpc_id = var.vpc_id
  name = "Amate-SG-K8s-Master"

  tags = {
    Name = "Amate-SG-K8s-Master"
    Project = "Amate"
    Type = "Security/SG/K8S/Master"
  }
}

resource "aws_security_group" "Amate-SG-K8s-Worker" {
  vpc_id = var.vpc_id
  name = "Amate-SG-K8s-Worker"

  tags = {
    Name = "Amate-SG-K8s-Worker"
    Project = "Amate"
    Type = "Security/SG/K8S/Worker"
  }
}

# Export Variable Config: Security

output "master_sgid" {
  value = aws_security_group.Amate-SG-K8s-Master.id
}

output "worker_sgid" {
  value = aws_security_group.Amate-SG-K8s-Worker.id
}