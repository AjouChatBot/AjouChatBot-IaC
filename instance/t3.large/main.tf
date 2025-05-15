# Instance Config Module: t3.large

resource "aws_instance" "t2_instance" {
  ami = "ami-05377cf8cfef186c2"
  instance_type = "t3.large"
  key_name = var.key_name
  
  subnet_id = var.subnet_id
  vpc_security_group_ids = [ var.security_group_id ]
  
  user_data = file("./scripts/t3.large.sh")

  tags = {
    Name = "[Amate] ${var.instance_name}"
    Project = "Amate"
    Type = "EC2/t3.large"
  }
}
