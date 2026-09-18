# --- HUB VPC ---
resource "aws_vpc" "hub" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "enterprise-hub-vpc"
  }
}

resource "aws_subnet" "hub_public" {
  vpc_id            = aws_vpc.hub.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "hub-public-subnet"
  }
}

resource "aws_internet_gateway" "hub_igw" {
  vpc_id = aws_vpc.hub.id

  tags = {
    Name = "hub-igw"
  }
}

resource "aws_route_table" "hub_rt" {
  vpc_id = aws_vpc.hub.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hub_igw.id
  }

  tags = {
    Name = "hub-public-rt"
  }
}

resource "aws_route_table_association" "hub_rta" {
  subnet_id      = aws_subnet.hub_public.id
  route_table_id = aws_route_table.hub_rt.id
}


# --- SPOKE VPC ---
resource "aws_vpc" "spoke" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "enterprise-spoke-vpc"
  }
}

resource "aws_subnet" "spoke_public" {
  vpc_id            = aws_vpc.spoke.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "spoke-public-subnet"
  }
}

resource "aws_subnet" "spoke_private_app" {
  vpc_id            = aws_vpc.spoke.id
  cidr_block        = "10.1.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "spoke-private-app-subnet"
  }
}

resource "aws_subnet" "spoke_private_db" {
  vpc_id            = aws_vpc.spoke.id
  cidr_block        = "10.1.3.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "spoke-private-db-subnet"
  }
}


# --- VPC PEERING (Hub <-> Spoke) ---
resource "aws_vpc_peering_connection" "hub_to_spoke" {
  vpc_id        = aws_vpc.hub.id
  peer_vpc_id   = aws_vpc.spoke.id
  auto_accept   = true

  tags = {
    Name = "hub-to-spoke-peering"
  }
}


# --- S3 GATEWAY VPC ENDPOINT (Securing Traffic) ---
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.spoke.id
  service_name = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    # Will route internal S3 traffic safely out of private subnets
  ]

  tags = {
    Name = "s3-private-endpoint"
  }
}
