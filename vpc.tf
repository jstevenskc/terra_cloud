resource "aws_vpc" "terra_vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"

    tags = {
        Name = "jon-vpc"
    }
}

variable "names" {
  default = ["jon-sn1","jon-sn2","jon-sn3"]
}

resource "aws_subnet" "terra_subnet" {
  vpc_id     = aws_vpc.terra_vpc.id
  cidr_block = "10.0.0.0/24"

 for_each = toset(var.names)
  tags = {
    Name = each.key
  }
}

resource "aws_route_table" "terra_rt" {
  vpc_id = aws_vpc.terra_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terra_igw.id
  }

  tags = {
    Name = "jon-rt"
  }
}

resource "aws_internet_gateway" "terra_igw" {
  vpc_id = aws_vpc.terra_vpc.id

  tags = {
    Name = "jon-igw"
  }
}

resource "aws_route_table_association" "terra_association" {
  for_each       = aws_subnet.terra_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.terra_rt.id
}
