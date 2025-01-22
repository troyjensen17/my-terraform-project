# variables.tf

# AWS region
variable "region" {
  description = "The AWS region to deploy resources in"
  default     = "us-east-1"
}

# VPC CIDR block
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

# Subnet CIDR block
variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
  default     = "10.0.1.0/24"
}

# Availability zone for the subnet
variable "availability_zone" {
  description = "The Availability Zone to deploy the subnet in"
  default     = "us-east-1a"
}

# Instance type for Kali Linux
variable "kali_instance_type" {
  description = "The instance type for Kali Linux"
  default     = "t2.micro"
}

# Instance type for Ubuntu
variable "ubuntu_instance_type" {
  description = "The instance type for Ubuntu"
  default     = "t2.micro"
}

# Instance type for Windows Server
variable "windows_instance_type" {
  description = "The instance type for Windows Server 2008"
  default     = "t2.micro"
}

