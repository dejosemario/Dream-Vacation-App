#!/bin/bash


# Update system packages
sudo apt-get update -y

# Install useful packages
sudo apt-get install -y htop curl wget unzip git

# Install Docker
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Start and enable Docker
sudo systemctl start docker
sudo systemctl enable docker

# Add ubuntu user to docker group
sudo usermod -aG docker ubuntu

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install CloudWatch Agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
sudo dpkg -i -E ./amazon-cloudwatch-agent.deb

# Create CloudWatch Agent configuration
sudo tee /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json > /dev/null <<EOF
{
    "agent": {
        "metrics_collection_interval": 60,
        "run_as_user": "cwagent"
    },
    "metrics": {
        "namespace": "CWAgent",
        "metrics_collected": {
            "cpu": {
                "measurement": [
                    "cpu_usage_idle",
                    "cpu_usage_iowait",
                    "cpu_usage_user",
                    "cpu_usage_system"
                ],
                "metrics_collection_interval": 60
            },
            "disk": {
                "measurement": [
                    "used_percent"
                ],
                "metrics_collection_interval": 60,
                "resources": [
                    "*"
                ]
            },
            "mem": {
                "measurement": [
                    "mem_used_percent"
                ],
                "metrics_collection_interval": 60
            }
        }
    },
    "logs": {
        "logs_collected": {
            "files": {
                "collect_list": [
                    {
                        "file_path": "/opt/dream_vacation/app/docker-compose.log",
                        "log_group_name": "dream-vacation-logs",
                        "log_stream_name": "{instance_id}"
                    },
                    {
                        "file_path": "/var/lib/docker/containers/*/*.log",
                        "log_group_name": "docker-container-logs",
                        "log_stream_name": "{container_id}"
                    }
                ]
            }
        }
    }
}
EOF

# Start CloudWatch Agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
    -a fetch-config \
    -m ec2 \
    -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json \
    -s

# Create directory for the application
sudo mkdir -p /home/ubuntu/dream-vacation-app
sudo chown ubuntu:ubuntu /home/ubuntu/dream-vacation-app

# Install AWS CLI 
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf aws awscliv2.zip


# Create a simple health check script
cat > /home/ubuntu/health-check.sh << 'HEALTH_EOF'
#!/bin/bash
echo "=== System Health Check ===" > /home/ubuntu/system-status.txt
echo "Date: $(date)" >> /home/ubuntu/system-status.txt
echo "Docker Status: $(sudo systemctl is-active docker)" >> /home/ubuntu/system-status.txt
echo "CloudWatch Agent Status: $(sudo systemctl is-active amazon-cloudwatch-agent)" >> /home/ubuntu/system-status.txt
echo "Disk Usage:" >> /home/ubuntu/system-status.txt
df -h >> /home/ubuntu/system-status.txt
echo "Memory Usage:" >> /home/ubuntu/system-status.txt
free -h >> /home/ubuntu/system-status.txt
HEALTH_EOF

chmod +x /home/ubuntu/health-check.sh
sudo chown ubuntu:ubuntu /home/ubuntu/health-check.sh

# Run initial health check
/home/ubuntu/health-check.sh

echo "User data script completed successfully at $(date)" >> /home/ubuntu/user-data.log
echo "You can check system status with: cat /home/ubuntu/system-status.txt" >> /home/ubuntu/user-data.log