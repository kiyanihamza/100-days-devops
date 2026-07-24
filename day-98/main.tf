
resource "aws_vpc" "xfusion_priv_vpc" {
  cidr_block           = var.KKE_VPC_CIDR
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "xfusion-priv-vpc"
  }
}

resource "aws_subnet" "xfusion_priv_subnet" {
  vpc_id                  = aws_vpc.xfusion_priv_vpc.id
  cidr_block              = var.KKE_SUBNET_CIDR
  map_public_ip_on_launch = false

  tags = {
    Name = "xfusion-priv-subnet"
  }
}

resource "aws_security_group" "xfusion_priv_sg" {
  name        = "xfusion-priv-sg"
  description = "Allow internal VPC access only"
  vpc_id      = aws_vpc.xfusion_priv_vpc.id

  ingress {
    description = "Allow all traffic from within the VPC CIDR"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.KKE_VPC_CIDR]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "xfusion-priv-sg"
  }
}

resource "aws_instance" "xfusion_priv_ec2" {
  ami                         = "ami-0c55b159cbfafe1f0"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.xfusion_priv_subnet.id
  vpc_security_group_ids      = [aws_security_group.xfusion_priv_sg.id]
  associate_public_ip_address = false

  tags = {
    Name = "xfusion-priv-ec2"
  }
}

