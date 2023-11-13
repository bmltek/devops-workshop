resource "aws_vpc" "dpp-vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "dpp-vpc"
  }
  
}

resource "aws_nat_gateway" "dpp-nat-gw" {
  allocation_id = aws_eip.dpp-nat-eip.id
  subnet_id     = aws_subnet.dpp-public-subnet-01.id
}

resource "aws_eip" "dpp-nat-eip" {
}

resource "aws_internet_gateway" "dpp-igw" {
  vpc_id = aws_vpc.dpp-vpc.id
  tags = {
    Name = "dpp-igw"
  }
}

resource "aws_route_table" "dpp-public-rt" {
  vpc_id = aws_vpc.dpp-vpc.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dpp-igw.id
  }
}

resource "aws_route_table" "dpp-private-rt" {
  vpc_id = aws_vpc.dpp-vpc.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.dpp-nat-gw.id
  }
}

resource "aws_subnet" "dpp-public-subnet-01" {
  vpc_id = aws_vpc.dpp-vpc.id
  cidr_block = "10.1.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
    Name = "dpp-public-subnet-01"
  }

}

resource "aws_subnet" "dpp-public-subnet-02" {
  vpc_id = aws_vpc.dpp-vpc.id
  cidr_block = "10.1.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"
  tags = {
    Name = "dpp-public-subnet-02"
  }

}

resource "aws_subnet" "dpp-private-subnet-01" {
  vpc_id = aws_vpc.dpp-vpc.id
  cidr_block = "10.1.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "dpp-private-subnet-01"
  }
 
}

resource "aws_subnet" "dpp-private-subnet-02" {
  vpc_id = aws_vpc.dpp-vpc.id
  cidr_block = "10.1.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "dpp-private-subnet-02"
  }

}
resource "aws_route_table_association" "dpp-rta-public-subnet-01" {
  subnet_id = aws_subnet.dpp-public-subnet-01.id
  route_table_id = aws_route_table.dpp-public-rt.id
}

resource "aws_route_table_association" "dpp-rta-public-subnet-02" {
  subnet_id = aws_subnet.dpp-public-subnet-02.id
  route_table_id = aws_route_table.dpp-public-rt.id
}

resource "aws_route_table_association" "dpp-rta-private-subnet-01" {
  subnet_id = aws_subnet.dpp-private-subnet-01.id
  route_table_id = aws_route_table.dpp-private-rt.id
}

resource "aws_route_table_association" "dpp-rta-private-subnet-02" {
  subnet_id = aws_subnet.dpp-private-subnet-02.id
  route_table_id = aws_route_table.dpp-private-rt.id
}

