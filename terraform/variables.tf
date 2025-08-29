variable "aws_region" {
  description = "AWS region to deploy the infrastructure"
  type        = string
  default     = "us-east-1"
}

#varible app name
variable "app_name" {
  description = "Name of the application"
  type        = string
  default     = "dream-vacation-app"
}

# VPC CIDR Block
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# EC2 Instance Type
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

# AWS Key Pair Name
variable "key_name" {
  description = "AWS key pair name"
  type        = string
  default     = "dream-vacation-keypair"
}

# Subnet CIDR Block
variable "subnet_cidr" {
  description = "CIDR block for subnet"
  type        = string
  default     = "10.0.1.0/24"
}

# Availability Zone
variable "availability_zone" {
  description = "Availability zone for subnet"
  type        = string
  default     = "us-east-1a"
}