# Security Group Rule Config Module: K8sWorker

# Input Variable Config

variable "master_sgid" {
  type = string
  description = "k8s master sg의 id"
}

variable "worker_sgid" {
  type = string
  description = "k8s worker sg의 id"
}

variable "ssh_allow_sgid" {
  type = string
  description = "k8s worker에 ssh 접속을 허용할 sgid"
}

# Security Group Rule Config

# SSH connection config
resource "aws_security_group_rule" "Amate-SG-K8s-Worker-SSH" {
  type = "ingress"

  from_port = 22
  to_port = 22
  protocol = "tcp"

  source_security_group_id = var.ssh_allow_sgid
  security_group_id = var.worker_sgid
}

# ## K8s connection config

# resource "aws_security_group_rule" "Amate-SG-K8s-Worker-Inbound-1" {
#   type = "ingress"

#   from_port = 6443
#   to_port = 6443
#   protocol = "tcp"

#   source_security_group_id = var.master_sgid
#   security_group_id = var.worker_sgid
# }

# resource "aws_security_group_rule" "Amate-SG-K8s-Worker-Inbound-2" {
#   type = "ingress"

#   from_port = 10250
#   to_port = 10250
#   protocol = "tcp"

#   source_security_group_id = var.master_sgid
#   security_group_id = var.worker_sgid
# }

# resource "aws_security_group_rule" "Amate-SG-K8s-Worker-Inbound-3" {
#   type = "ingress"

#   from_port = 30000
#   to_port = 32767
#   protocol = "tcp"

#   source_security_group_id = var.master_sgid
#   security_group_id = var.worker_sgid
# }

# resource "aws_security_group_rule" "Amate-SG-K8s-Worker-Inbound-4" {
#   type = "ingress"

#   from_port = 30000
#   to_port = 32767
#   protocol = "udp"

#   source_security_group_id = var.master_sgid
#   security_group_id = var.worker_sgid
# }

resource "aws_security_group_rule" "Amate-SG-K8s-Worker-Inbound-Master-TCP" {
  type = "ingress"

  from_port = 0
  to_port = 65535
  protocol = "tcp"

  source_security_group_id = var.master_sgid
  security_group_id = var.worker_sgid
}

resource "aws_security_group_rule" "Amate-SG-K8s-Worker-Inbound-Master-UDP" {
  type = "ingress"

  from_port = 0
  to_port = 65535
  protocol = "udp"

  source_security_group_id = var.master_sgid
  security_group_id = var.worker_sgid
}

resource "aws_security_group_rule" "Amate-SG-K8s-Worker-Outbound-Master-TCP" {
  type = "egress"

  from_port = 0
  to_port = 65535
  protocol = "tcp"

  source_security_group_id = var.master_sgid
  security_group_id = var.worker_sgid
}

resource "aws_security_group_rule" "Amate-SG-K8s-Worker-Outbound-Master-UDP" {
  type = "egress"

  from_port = 0
  to_port = 65535
  protocol = "udp"

  source_security_group_id = var.master_sgid
  security_group_id = var.worker_sgid
}

resource "aws_security_group_rule" "Amate-SG-K8s-Worker-Inbound-Common-TCP" {
  type = "ingress"

  cidr_blocks = [ "0.0.0.0/0" ]
  from_port = 0
  to_port = 65535
  protocol = "tcp"
  
  security_group_id = var.worker_sgid
}

resource "aws_security_group_rule" "Amate-SG-K8s-Worker-Inbound-Common-UDP" {
  type = "ingress"

  cidr_blocks = [ "0.0.0.0/0" ]
  from_port = 0
  to_port = 65535
  protocol = "udp"
  
  security_group_id = var.worker_sgid
}

resource "aws_security_group_rule" "Amate-SG-K8s-Worker-Outbound-Common-TCP" {
  type = "egress"

  cidr_blocks = [ "0.0.0.0/0" ]
  from_port = 0
  to_port = 65535
  protocol = "tcp"
  
  security_group_id = var.worker_sgid
}

resource "aws_security_group_rule" "Amate-SG-K8s-Worker-Outbound-Common-UDP" {
  type = "egress"

  cidr_blocks = [ "0.0.0.0/0" ]
  from_port = 0
  to_port = 65535
  protocol = "udp"
  
  security_group_id = var.worker_sgid
}