# main.tf

# Configure the AWS provider
provider "aws" {
  region = "us-east-1"
}

# Create a new SSH Key pair for Kali Linux
resource "aws_key_pair" "kali_key" {
  key_name   = "kali_ssh_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDIgrJjGPjc8dGK/PXK5i+4Ypm21oALmqH/4KXTkAPGxNNgMCAPNqAEHH50oyg7WTT6kmvSGzQwMIcYofGiNXnQdCQ44rd29WRWrSjuUkmOQrlrDDW8ivqLEXGDBfoxi++/hwNknIdqyUXG/zLK6Mfq676M93NITgpaemF5QFrLCbHrIuCcRInTmUZpHCQZ7x6iu1EOTcWgWY9ekkylNBX8uCCRj2DlJ6CNuSxNByzs7auyam+iZYB1NzKjoe2HMJrioR/fA8oGiG2aNh9NQL4vdMig4TwncTMDdzl82YdxBnD7MVEfyrqzF3f2wazLkF2a9oWGfIBZQuc66rW0SRXH troyjensen@Troys-MacBook-Pro.local"
}

# Create a new SSH Key pair for Ubuntu
resource "aws_key_pair" "ubuntu_key" {
  key_name   = "ubuntu_ssh_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDIgrJjGPjc8dGK/PXK5i+4Ypm21oALmqH/4KXTkAPGxNNgMCAPNqAEHH50oyg7WTT6kmvSGzQwMIcYofGiNXnQdCQ44rd29WRWrSjuUkmOQrlrDDW8ivqLEXGDBfoxi++/hwNknIdqyUXG/zLK6Mfq676M93NITgpaemF5QFrLCbHrIuCcRInTmUZpHCQZ7x6iu1EOTcWgWY9ekkylNBX8uCCRj2DlJ6CNuSxNByzs7auyam+iZYB1NzKjoe2HMJrioR/fA8oGiG2aNh9NQL4vdMig4TwncTMDdzl82YdxBnD7MVEfyrqzF3f2wazLkF2a9oWGfIBZQuc66rW0SRXH troyjensen@Troys-MacBook-Pro.local"
}

# Create a new SSH Key pair for Windows Server 2008
resource "aws_key_pair" "windows_key" {
  key_name   = "windows_ssh_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDIgrJjGPjc8dGK/PXK5i+4Ypm21oALmqH/4KXTkAPGxNNgMCAPNqAEHH50oyg7WTT6kmvSGzQwMIcYofGiNXnQdCQ44rd29WRWrSjuUkmOQrlrDDW8ivqLEXGDBfoxi++/hwNknIdqyUXG/zLK6Mfq676M93NITgpaemF5QFrLCbHrIuCcRInTmUZpHCQZ7x6iu1EOTcWgWY9ekkylNBX8uCCRj2DlJ6CNuSxNByzs7auyam+iZYB1NzKjoe2HMJrioR/fA8oGiG2aNh9NQL4vdMig4TwncTMDdzl82YdxBnD7MVEfyrqzF3f2wazLkF2a9oWGfIBZQuc66rW0SRXH troyjensen@Troys-MacBook-Pro.local"
}

# Create a VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "main_vpc"
  }
}

# Create a subnet
resource "aws_subnet" "main_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "main_subnet"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "main_igw"
  }
}

# Create a route table and associate it
resource "aws_route_table" "main_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }
  tags = {
    Name = "main_route_table"
  }
}

resource "aws_route_table_association" "main_route_table_association" {
  subnet_id      = aws_subnet.main_subnet.id
  route_table_id = aws_route_table.main_route_table.id
}

# Kali Linux Instance
resource "aws_instance" "kali_linux" {
  ami             = "ami-02be3d7604aff56a7"  # Kali Linux AMI
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.kali_key.key_name
  security_groups = [aws_security_group.kali_sg.name]
  subnet_id       = aws_subnet.main_subnet.id
  associate_public_ip_address = true

  tags = {
    Name = "Kali Linux Instance"
  }
}

# Ubuntu Instance
resource "aws_instance" "ubuntu" {
  ami             = "ami-d83d0782-cb94-46d7-8993-f4ce15d1a484"  # Ubuntu AMI
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.ubuntu_key.key_name
  security_groups = [aws_security_group.ubuntu_sg.name]
  subnet_id       = aws_subnet.main_subnet.id
  associate_public_ip_address = true

  tags = {
    Name = "Ubuntu Instance"
  }
}

# Windows Server 2008 Instance
resource "aws_instance" "windows_server_2008" {
  ami             = "ami-2641882d-acdb-46b1-9331-478ffca58e3c"  # Windows Server 2008 AMI
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.windows_key.key_name
  security_groups = [aws_security_group.windows_sg.name]
  subnet_id       = aws_subnet.main_subnet.id
  associate_public_ip_address = true

  tags = {
    Name = "Windows Server 2008 Instance"
  }
}

