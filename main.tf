resource "aws_vpc" "nextwork_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "NextWork_VPC"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.nextwork_vpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "Public"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.nextwork_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Private"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.nextwork_vpc.id

  tags = {
    Name = "NextWork_IGW"
  }
}

# Redirect all externel communication to the internet gateway
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.nextwork_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "Public_route_table"
  }
}

#Keep traffic internal
resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.nextwork_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
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
  vpc_id = aws_vpc.nextwork_vpc.id

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
  vpc_id = aws_vpc.nextwork_vpc.id

  ingress {
    protocol   = "icmp"
    rule_no    = 100
    cidr_block = "10.0.0.0/24"
    from_port  = 0
    to_port    = 0
    action     = "allow"
    icmp_code = -1
    icmp_type = -1
  }
  egress {
    protocol   = "icmp"
    rule_no    = 100
    cidr_block = "10.0.0.0/24"
    from_port  = 0
    to_port    = 0
    action     = "allow"
    icmp_code = -1
    icmp_type = -1
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
  name        = "NextWork Public Security Group"
  description = "Security group for NextWork Public Subnet."
  vpc_id      = aws_vpc.nextwork_vpc.id

  tags = {
    Name = "NextWork Public Security Group"
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

# Allow all outbound traffic from the public server
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.public_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1
  from_port         = 0
  to_port           = 0
}

resource "aws_security_group" "private_group" {
  name        = "NextWork Private Security Group"
  description = "Security group for NextWork Private Subnet."
  vpc_id      = aws_vpc.nextwork_vpc.id

  tags = {
    Name = "NextWork Private Security Group"
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