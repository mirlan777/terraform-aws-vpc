resource "aws_subnet" "public_subnet1" {
  depends_on = [
    aws_vpc.main
  ]

  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_cidr1
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = var.tags
  map_public_ip_on_launch = true
}
resource "aws_subnet" "public_subnet2" {
  depends_on = [
    aws_vpc.main
  ]
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_cidr2
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = var.tags
   map_public_ip_on_launch = true

}
resource "aws_subnet" "public_subnet3" {
  depends_on = [
    aws_vpc.main
  ]
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_cidr3
  availability_zone = data.aws_availability_zones.available.names[2]
  tags = var.tags
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "gw" {

  vpc_id = aws_vpc.main.id
  tags = var.tags
}

resource "aws_route_table" "public" {
  depends_on = [
    aws_vpc.main,
    aws_internet_gateway.gw
  ]
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = var.tags
}


resource "aws_route_table_association" "public1" {
 
  subnet_id = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public2" {
 
  subnet_id = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public3" {
  
  subnet_id = aws_subnet.public_subnet3.id
  route_table_id = aws_route_table.public.id
}

