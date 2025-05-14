# Instance Config Module: t2.micro

resource "aws_instance" "t2_instance" {
  ami = "ami-05377cf8cfef186c2"
  instance_type = "t2.micro"
  key_name = var.key_name
  
  subnet_id = var.subnet_id
  vpc_security_group_ids = [ var.security_group_id ]
  
  user_data = file("./scripts/t2.micro.sh")

  tags = {
    Name = "[Amate] ${var.instance_name}"
    Project = "Amate"
    Type = "EC2/t2.micro"
  }
}
