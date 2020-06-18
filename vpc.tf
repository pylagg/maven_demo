
#Define our VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/26"
  enable_dns_hostnames = true

  tags ={
    Name = "terra-vpc"
  }
}
# Define the public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.0.0/27"
  availability_zone = "us-east-1a"

  tags ={
    Name = "Public Subnet"
  }
}

# Define the private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.0.32/27"
  availability_zone = "us-east-1b"

  tags ={
    Name = "Private Subnet"
  }
}

# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags ={
    Name = "VPC IGW"
  }
}

# Define the route table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags ={
    Name = "Public Subnet RT"
  }
}

# Assign the route table to the public Subnet
resource "aws_route_table_association" "public-rt" {
  subnet_id = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}

# Define the security group for public subnet
resource "aws_security_group" "public-sg" {
  description = "Allow incoming HTTP connections & SSH access"
  name = "public SG"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  vpc_id = aws_vpc.main.id

  tags ={
    Name = "Public SG"
  }
}
# Define the security group for private subnet
resource "aws_security_group" "sg_private"{
  description = "Allow traffic from public subnet"
  name = "Private SG"
  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks =  ["0.0.0.0/0"]
  }
 ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["10.0.0.0/27"]
  }

  vpc_id = aws_vpc.main.id

  tags ={
    Name = "Private SG"
  }
}

