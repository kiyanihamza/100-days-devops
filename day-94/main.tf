resource "aws_vpc" "xfusion-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "xfusion-vpc"
  }
}