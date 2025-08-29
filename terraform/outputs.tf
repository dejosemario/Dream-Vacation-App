# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.dream_vpc.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.dream_vpc.cidr_block
}

# Subnet Outputs
output "subnet_id" {
  description = "ID of the subnet"
  value       = aws_subnet.dream_subnet.id
}

output "subnet_cidr_block" {
  description = "CIDR block of the subnet"
  value       = aws_subnet.dream_subnet.cidr_block
}

# Internet Gateway Output
output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.dream_igw.id
}

# Route Table Output
output "route_table_id" {
  description = "ID of the route table"
  value       = aws_route_table.dream_rt.id
}

# Security Group Output
output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.dream_sg.id
}

# EC2 Instance Outputs
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.dream_app_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.dream_app_server.public_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.dream_app_server.public_dns
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.dream_app_server.private_ip
}

# CloudWatch Alarm Output
output "cloudwatch_alarm_name" {
  description = "Name of the CloudWatch CPU alarm"
  value       = aws_cloudwatch_metric_alarm.cpu_alarm.alarm_name
}

# SSH Connection Command
output "ssh_connection_command" {
  description = "Command to SSH into the EC2 instance"
  value       = "ssh -i ${var.key_name}.pem ubuntu@${aws_instance.dream_app_server.public_ip}"
}

# Application URL
output "application_url" {
  description = "URL to access the Dream Vacation App"
  value       = "http://${aws_instance.dream_app_server.public_ip}"
}