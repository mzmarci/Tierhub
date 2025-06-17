#!/bin/bash

# Update package list
sudo yum update -y
sudo yum install git -y

# ------------------------
# Install Nginx
# ------------------------
sudo amazon-linux-extras enable nginx1
sudo yum install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# ------------------------
# Install Docker
# ------------------------
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.7/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose


# Verify versions
docker --version
docker-compose --version