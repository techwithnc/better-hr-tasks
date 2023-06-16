resource "aws_vpc" "vpc01" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "${var.tenancy}"

  tags = {
    Name = "aws_vpc01"
  }
}

resource "aws_subnet" "public_subnet01" {
  vpc_id     = aws_vpc.vpc01.id
  cidr_block = "${var.subnet_cidrs[0]}"
  availability_zone = "${var.avail_zones[0]}"
  tags = {
    Name = "public_subnet01"
  }
}

resource "aws_subnet" "public_subnet02" {
  vpc_id     = aws_vpc.vpc01.id
  cidr_block = "${var.subnet_cidrs[1]}"
  availability_zone = "${var.avail_zones[1]}"
  tags = {
    Name = "public_subnet02"
  }
}

# Security group for instance.
resource "aws_security_group" "sg01" {
  name        = "allow_web-traffic"
  description = "Allow web-traffice inbound traffic"
  vpc_id      = aws_vpc.vpc01.id

  ingress {
    description      = "Allow 8080"
    from_port        = "${var.ingress_ports[0]}"
    to_port          = "${var.ingress_ports[0]}"
    protocol         = "${var.protocol}"
    security_groups = [aws_security_group.sg02.id]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_8080_only_from_loadbalaner"
  }
}
# Security group for loadbalancer.
resource "aws_security_group" "sg02" {
  name        = "allow_web-traffic-sg02"
  description = "Allow web-traffice inbound traffic"
  vpc_id      = aws_vpc.vpc01.id

  ingress {
    description      = "Allow 80"
    from_port        = "${var.ingress_ports[1]}"
    to_port          = "${var.ingress_ports[1]}"
    protocol         = "${var.protocol}"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "Allow 443"
    from_port        = "${var.ingress_ports[2]}"
    to_port          = "${var.ingress_ports[2]}"
    protocol         = "${var.protocol}"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-80-443"
  }
}

resource "aws_internet_gateway" "gw01" {
  vpc_id = aws_vpc.vpc01.id

  tags = {
    Name = "gateway01"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw01.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.gw01.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public01" {
  subnet_id      = aws_subnet.public_subnet01.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public02" {
  subnet_id      = aws_subnet.public_subnet02.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "eip01" {
  tags = {
    Name    = "elastic_ip01"
  }
}

