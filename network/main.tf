
# VPC Config | =============================
resource "aws_vpc" "Amate-VPC" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Amate-VPC"
    Project = "Amate"
    Type = "Network/VPC"
  }
}

# Subnet Config | =============================
resource "aws_subnet" "Amate-Public-A" {
  vpc_id = aws_vpc.Amate-VPC.id
  cidr_block = "10.0.10.0/24"
  availability_zone = "ap-northeast-2"
  map_public_ip_on_launch = false
  tags = {
    Name = "Amate-Public-A"
    Project = "Amate"
    Type = "Network/Subnet"
  }
}

resource "aws_subnet" "Amate-Private-A" {
  vpc_id = aws_vpc.Amate-VPC.id
  cidr_block = "10.0.20.0/24"
  availability_zone = "ap-northeast-2"
  map_public_ip_on_launch = false
  tags = {
    Name = "Amate-Private-A"
    Project = "Amate"
    Type = "Network/Subnet"
  }
}

# IGW Config | =============================
resource "aws_internet_gateway" "Amate-IGW" {
  vpc_id = aws_vpc.Amate-VPC.id

  tags = {
    Name = "Amate-IGW"
    Project = "Amate"
    Type = "Network/IGW"
  }
}

# EIP Config | =============================
resource "aws_eip" "Amate-NAT-EIP" {
  domain = "vpc"
  tags = {
    Name = "Amate-NAT-EIP"
    Project = "Amate"
    Type = "Network/EIP"
  }
}

# NAT Gateway Config | =============================
resource "aws_nat_gateway" "Amate-NAT-GW" {
  allocation_id = aws_eip.Amate-NAT-EIP.id
  subnet_id = aws_subnet.Amate-Public-A.id

  tags = {
    Name = "Amate-NAT-GW"
    Project = "Amate"
    Type = "Network/NAT"
  }
}

# Routing Config | =============================
resource "aws_route_table" "Amate-Public-A-Route" {
  vpc_id = aws_vpc.Amate-VPC.id

  route { // 라우팅: 0.0.0.0/0 -> 외부
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Amate-IGW.id
  }

  tags = {
    Name = "Amate-Public-A-Route"
    Project = "Amate"
    Type = "Network/RouteTable"
  }
}
resource "aws_route_table_association" "Amate-Public-A-Route-Connect" {
  subnet_id = aws_subnet.Amate-Public-A.id
  route_table_id = aws_route_table.Amate-Public-A-Route.id
}

resource "aws_route_table" "Amate-Private-A-Route" {
  vpc_id = aws_vpc.Amate-VPC.id

  route { // 라우팅: 0.0.0.0/0 -> NAT
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.Amate-NAT-GW.id
  }

  tags = {
    Name = "Amate-Private-A-Route"
    Project = "Amate"
    Type = "Network/RouteTable"
  }
}
resource "aws_route_table_association" "Amate-Private-A-Route-Connect" {
  subnet_id = aws_subnet.Amate-Private-A.id
  route_table_id = aws_route_table.Amate-Private-A-Route.id
}