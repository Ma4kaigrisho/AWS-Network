resource "aws_vpc" "production_vpc" {
  cidr_block = var.first_vpc_ip
  tags = {
    Name = "Production VPC"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.production_vpc.id
  cidr_block = "10.1.0.0/24"

  tags = {
    Name = "Public"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.production_vpc.id
  cidr_block = "10.1.1.0/24"

  tags = {
    Name = "Private"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.production_vpc.id

  tags = {
    Name = "Production IGW"
  }
}

# Redirect all externel communication to the internet gateway
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.production_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route  {
    cidr_block = "10.2.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  }

  tags = {
    Name = "Public_route_table"
  }
}

#Keep traffic internal
resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.production_vpc.id
  
  route  {
    cidr_block = "10.2.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  }

  tags = {
    Name = "Private_route_table"
  }
}

resource "aws_route_table_association" "pub" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "priv" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_route.id
}

# Allow all traffic for the public server
resource "aws_network_acl" "public_acl" {
  vpc_id = aws_vpc.production_vpc.id

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "Public_ACL"
  }
}

resource "aws_network_acl_association" "pub_acl" {
  subnet_id      = aws_subnet.public.id
  network_acl_id = aws_network_acl.public_acl.id
}

#Allow icmp traffic from and to the private subnet. ICMP type and code are set to -1 to allow all ICMP traffic
resource "aws_network_acl" "private_acl" {
  vpc_id = aws_vpc.production_vpc.id

  ingress {
    protocol   = "icmp"
    rule_no    = 100
    cidr_block = "10.1.0.0/24"
    from_port  = 0
    to_port    = 0
    action     = "allow"
    icmp_code  = -1
    icmp_type  = -1
  }
  egress {
    protocol   = "icmp"
    rule_no    = 100
    cidr_block = "10.1.0.0/24"
    from_port  = 0
    to_port    = 0
    action     = "allow"
    icmp_code  = -1
    icmp_type  = -1
  }
  tags = {
    Name = "Private_ACL"
  }
}

resource "aws_network_acl_association" "priv_acl" {
  subnet_id      = aws_subnet.private.id
  network_acl_id = aws_network_acl.private_acl.id
}

resource "aws_security_group" "public_group" {
  name        = "production Public Security Group"
  description = "Security group for production Public Subnet."
  vpc_id      = aws_vpc.production_vpc.id

  tags = {
    Name = "Production Public Security Group"
  }
}

# Allow SSH connection to the public server
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_inbound" {
  security_group_id = aws_security_group.public_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

# Allow HTTP communication to the public server
resource "aws_vpc_security_group_ingress_rule" "allow_http_inbound" {
  security_group_id = aws_security_group.public_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "icmp_inbound_pub_all" {
  security_group_id = aws_security_group.public_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "icmp"
  from_port         = -1
  to_port           = -1
}

# Allow all outbound traffic from the public server
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.public_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1
  from_port         = 0
  to_port           = 0
}

resource "aws_security_group" "private_group" {
  name        = "production Private Security Group"
  description = "Security group for production Private Subnet."
  vpc_id      = aws_vpc.production_vpc.id

  tags = {
    Name = "production Private Security Group"
  }
}

# Allow SSH connection to the private server only from the Public security group
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id            = aws_security_group.private_group.id
  referenced_security_group_id = aws_security_group.public_group.id
  ip_protocol                  = "tcp"
  from_port                    = 22
  to_port                      = 22
}

# Allow ICMP traffic to the private instance
resource "aws_vpc_security_group_ingress_rule" "allow_icmp_inbound" {
  security_group_id            = aws_security_group.private_group.id
  referenced_security_group_id = aws_security_group.public_group.id
  ip_protocol                  = "icmp"
  from_port                    = -1
  to_port                      = -1
}

# Allow ICMP traffic from the private instance
resource "aws_vpc_security_group_egress_rule" "allow_icmp_outbound" {
  security_group_id            = aws_security_group.private_group.id
  referenced_security_group_id = aws_security_group.public_group.id
  ip_protocol                  = "icmp"
  from_port                    = -1
  to_port                      = -1
}
resource "aws_key_pair" "public" {
  key_name   = "public"
  public_key = file("public.pub")
}

resource "aws_key_pair" "private" {
  key_name   = "private"
  public_key = file("private.pub")
}

resource "aws_instance" "web" {
  ami                         = "ami-0b46816ffa1234887"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.public_group.id]
  key_name                    = aws_key_pair.public.key_name
  tags = {
    Name = "Public Web Server"
  }
}

resource "aws_instance" "private_ins" {
  ami                    = "ami-0b46816ffa1234887"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private.id
  key_name               = aws_key_pair.private.key_name
  vpc_security_group_ids = [aws_security_group.private_group.id]
  tags = {
    Name = "Private Machine"
  }
}

resource "aws_vpc" "second_vpc" {
  cidr_block = var.second_vpc_ip
  tags = {
    Name = "Staging VPC"
  }
}

resource "aws_subnet" "staging_subnet" {
  vpc_id     = aws_vpc.second_vpc.id
  cidr_block = "10.2.0.0/24"
  tags = {
    Name = "Staging Public Subnet"
  }
}

resource "aws_internet_gateway" "staging_igw" {
  vpc_id = aws_vpc.second_vpc.id
  tags = {
    Name = "Staging Internet Gateway"
  }
}

resource "aws_route_table" "staging_rt" {
  vpc_id = aws_vpc.second_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.staging_igw.id
  }

  route  {
    cidr_block = "10.1.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  }

  tags = {
    Name = "Staging Route Table"
  }
}

resource "aws_route_table_association" "staging_rt_a" {
  route_table_id = aws_route_table.staging_rt.id
  subnet_id      = aws_subnet.staging_subnet.id
}

resource "aws_network_acl" "staging_acl" {
  vpc_id = aws_vpc.second_vpc.id
  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}

resource "aws_network_acl_association" "staging_acl_a" {
  subnet_id      = aws_subnet.staging_subnet.id
  network_acl_id = aws_network_acl.staging_acl.id
}

resource "aws_security_group" "staging_sg" {
  vpc_id = aws_vpc.second_vpc.id
  tags = {
    Name = "Staging Security Group"
  }
}

resource "aws_vpc_security_group_egress_rule" "icmp_inbound_all" {
  security_group_id = aws_security_group.staging_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "icmp"
  from_port         = -1
  to_port           = -1
}

resource "aws_vpc_security_group_ingress_rule" "icmp_outbound_all" {
  security_group_id = aws_security_group.staging_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "icmp"
  from_port         = -1
  to_port           = -1
}

resource "aws_instance" "staging_instance" {
  ami                         = "ami-0b46816ffa1234887"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.staging_subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.staging_sg.id]
  tags = {
    Name = "Staging Web server"
  }
}

resource "aws_vpc_peering_connection" "peer" {
  vpc_id      = aws_vpc.production_vpc.id
  peer_vpc_id = aws_vpc.second_vpc.id
  auto_accept = true
}