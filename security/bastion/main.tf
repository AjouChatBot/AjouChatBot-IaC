# Security Group Config Module: Bastion
resource "aws_security_group" "Amate-SG-Bastion" {
  vpc_id = var.vpc_id
  name = "Amate-SG-Bastion"

  tags = {
    Name = "Amate-SG-Bastion"
    Project = "Amate"
    Type = "Security/SG/Bastion"
  }
}

resource "aws_security_group_rule" "Amate-SG-Bastion-Inbound-1" {
  type = "ingress"

  cidr_blocks = [ "0.0.0.0/0" ]
  from_port = 50022
  to_port = 50022
  protocol = "tcp"

  security_group_id = aws_security_group.Amate-SG-Bastion.id
}