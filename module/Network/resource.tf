resource "aws_vpc" "vpc" {
    
    cidr_block = var.AWS_VPC_CIDR
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "vpc_dev"
        Environment = "DEV"  
    }

}

resource "aws_internet_gateway" "igw" {

    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "vpc_dev"
        Environment = "DEV"  
    }

}

resource "aws_subnet" "public_subnet" {

    vpc_id = aws_vpc.vpc.id
    cidr_block = var.AWS_PUBLICSUBNET_CIDR
    availability_zone = var.AWS_PUBLIC_AZ
    map_public_ip_on_launch = true
    tags = {
        Name = "Public_subnet_dev"
        Environment = "DEV"
    }

}

resource "aws_route_table" "public_rtb" {

    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
   
}

resource "aws_route_table_association" "public_rtb_asc" {

    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_rtb.id

}
