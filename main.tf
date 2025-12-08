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

resource "aws_network_acl" "private_acl" {
  vpc_id = aws_vpc.nextwork_vpc.id

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

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_inbound" {
  security_group_id = aws_security_group.public_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_inbound" {
  security_group_id = aws_security_group.public_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
}

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

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id            = aws_security_group.private_group.id
  referenced_security_group_id = aws_security_group.public_group.id
  ip_protocol                  = "tcp"
  from_port                    = 22
  to_port                      = 22
}

data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["137112412989"] # Canonical
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
  ami                         = data.aws_ami.ami.id
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
  ami                    = data.aws_ami.ami.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private.id
  key_name               = aws_key_pair.private.key_name
  vpc_security_group_ids = [aws_security_group.private_group.id]
  tags = {
    Name = "Private Machine"
  }
}