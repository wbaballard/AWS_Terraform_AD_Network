resource "aws_vpc" "directory_service_vpc" {
  cidr_block = "10.10.0.0/16"
}
resource "aws_subnet" "directory_service_subnet_1" {
  vpc_id            = aws_vpc.directory_service_vpc.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.10.1.0/24"
}
resource "aws_subnet" "directory_service_subnet_2" {
  vpc_id            = aws_vpc.directory_service_vpc.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.10.2.0/24"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "mitre-dev"
  cidr   = "10.10.0.0/16"
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.10.1.0/24", "10.10.2.0/24"]
  public_subnets  = ["10.10.3.0/24", "10.10.4.0/24"]
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = "mitre-dev"
    Environment = "Development"
  }
}

resource "aws_directory_service_directory" "aws-managed-ad" {
  name        = "dev.mitre-dev.local"
  description = "MITRE Managed Directory Service"
  password    = "Sup3rS3cr3tP@ssw0rd"
  edition     = "Standard"
  type        = "MicrosoftAD"
  vpc_settings {
    vpc_id     = module.vpc.vpc_id
    subnet_ids = module.vpc.private_subnets
  }
  tags = {
    Name        = "aws-managed-ad"
    Environment = "Development"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.directory_service_vpc.id
}

resource "aws_route_table" "prod-route-table" {
  vpc_id = aws_vpc.directory_service_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.directory_service_subnet_1.id
  route_table_id = aws_route_table.prod-route-table.id
}

resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.directory_service_vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# GitLab
resource "aws_network_interface" "gl-server-nic" {
  subnet_id       = aws_subnet.directory_service_subnet_1.id
  private_ips     = ["10.10.1.50"]
  security_groups = [aws_security_group.allow_web.id]
}

resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.gl-server-nic.id
  associate_with_private_ip = "10.10.1.50"
  depends_on                = [aws_internet_gateway.gw]
}

# Workstation 1
resource "aws_network_interface" "workstation1-nic" {
  subnet_id       = aws_subnet.directory_service_subnet_1.id
  private_ips     = ["10.10.1.25"]
  security_groups = [aws_security_group.allow_web.id]
}

resource "aws_eip" "two" {
  vpc                       = true
  network_interface         = aws_network_interface.workstation1-nic.id
  associate_with_private_ip = "10.10.1.25"
  depends_on                = [aws_internet_gateway.gw]
}

# Workstation 2
resource "aws_network_interface" "workstation2-nic" {
  subnet_id       = aws_subnet.directory_service_subnet_1.id
  private_ips     = ["10.10.1.75"]
  security_groups = [aws_security_group.allow_web.id]
}

resource "aws_eip" "three" {
  vpc                       = true
  network_interface         = aws_network_interface.workstation2-nic.id
  associate_with_private_ip = "10.10.1.75"
  depends_on                = [aws_internet_gateway.gw]
}

# Public IP
output "server_public_ip" {
  value = aws_eip.one.public_ip
}

