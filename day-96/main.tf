resource "aws_instance" "nautilus_ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  key_name      = "nautilus-kp"

  tags = {
    Name = "Nautilus EC2 Instance"
  }
  
}