variable "vpc_id" {
  description = "ID de la VPC"
}

variable "cidr_block" {
  description = "CIDR block para la subred pública"
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_block
  availability_zone = "us-west-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet"
  }
}
