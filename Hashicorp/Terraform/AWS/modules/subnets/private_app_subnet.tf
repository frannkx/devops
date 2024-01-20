variable "vpc_id" {
  description = "ID de la VPC"
}

variable "cidr_block" {
  description = "CIDR block para la subred privada de aplicaciones"
}

resource "aws_subnet" "private_app_subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_block
  availability_zone = "us-west-1a"

  tags = {
    Name = "Private App Subnet"
  }
}
