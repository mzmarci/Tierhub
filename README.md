## 🚀 Tierhub – 3-Tier Application (Local Deployment Guide)

## 🧩 Project Overview
This project demonstrates how to run a 3-tier web application locally using Docker Compose and manual setup. The application consists of:

Web Tier: React frontend running on port 3000

App Tier: Node.js backend API running on port 4000

Database Tier: MySQL running in a container

##  Manual Setup (Without Docker)
##  Step 1: Install Dependencies
Make sure the following are installed on your machine:

Node.js and npm

MySQL

## Error 1: MySQL Connection Issue – ER_NOT_SUPPORTED_AUTH_MODE
##  Problem:
When starting the backend (npm start), you might get this error:
ER_NOT_SUPPORTED_AUTH_MODE: Client does not support authentication protocol requested by server

## Solution:
Log into MySQL:

mysql -u {DB_USER} -p -h localhost {DB_DATABASE}
Then run:

ALTER USER '{DB_USER}'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
FLUSH PRIVILEGES;
N.B - {DB_USER} - this is the name you want to give your db 

## Error 2: Missing MySQL Package
## Problem:

Error: Cannot find module 'mysql'

##  Solution:
Install the MySQL Node.js driver:


npm install mysql

## Error 3: Cannot GET / on http://localhost:4000
## Problem:
Accessing the backend directly gives:

Cannot GET /

## Solution:
The backend is an API server, not a webpage. Visit the API route:

http://localhost:4000/transaction
You should see:

{"result":[]}
This means the app is running but the database is empty.

## 🐳 Running with Docker Compose
To deploy the app with Docker Compose:


docker-compose up --build
## Notes:
Reverse Proxy: The web tier uses NGINX as a reverse proxy.
In nginx.conf, update the proxy_pass value (line 11) to match the backend service name defined in your docker-compose.yml, for example:

proxy_pass http://app:4000;
Also make sure your nginx.conf is copied in your web-tier Dockerfile correctly.

the app in line 70 should be the name of your backend in your dockercompose file

## Common Docker Issues & Fixes
## 1. Broken Dockerfile (Missing Build Script)
## Problem:
RUN npm run build fails with:

npm error Missing script: "build"
## Solution:
Removed RUN npm run build because the backend didn’t require a build step (used in static sites or compiled apps like React).

##  2. Backend Starts Before Database is Ready
## Problem:
App-tier crashes due to MySQL not being ready.

## Solution:
Used wait-for-it.sh to delay backend start until MySQL is available:

CMD ["./wait-for-it.sh", "db:3306", "--", "npm", "start"]

## 3. Script Not Executable in Container
Problem:
wait-for-it.sh not running inside container.

Solution:
Added execution permission:

RUN chmod +x /wait-for-it.sh

##  4. Docker Networking – Container Cannot Connect
## Problem:
Backend can’t connect to database.

## Solution:
In Docker Compose, services communicate using their service names. Used db as the MySQL hostname inside the app-tier.

## 5. Wrong Port Exposure
## Problem:
Backend runs but nothing shows on browser.

## Solution:

Backend listens on port 4000.

Dockerfile includes: EXPOSE 4000

Confirmed server.js is listening on the same port.

##  Summary
This project showcases both manual and Docker-based deployment of a 3-tier app. Beginners can follow the troubleshooting steps to understand:

Application layering

Basic database debugging

Docker Compose networking

Service dependency handling

##   Taking Tierhub Further — CI/CD, Code Quality, and EC2 Deployment
This project extends the Tierhub 3-tier app by automating the CI/CD process using GitHub Actions, pushing Docker images to an EC2 server, and integrating SonarQube for code quality analysis using a quality gate.

##  What’s Implemented
✅ GitHub Actions for CI/CD pipeline

✅ Docker Compose to build and manage services

✅ Docker Hub to store images

✅ EC2 instance for hosting the app

✅ SonarQube for static code analysis and quality gating

✅ Infrastructure automated using Terraform modules (VPC, ALB, Security Groups, EC2)

##  How It Works
# GitHub Actions Workflow Explained
- Workflow Trigger:
- The pipeline runs whenever you push to the main branch.

- Environment Setup:
- Secrets and variables are defined for DockerHub login, EC2 credentials, and SonarQube config.

- Pipeline Steps Include:

- Checking out the repository

- Building Docker images from docker-compose.yml

- Running a SonarQube scan and waiting for the quality gate

- Tagging and pushing Docker images to DockerHub

- SSHing into the EC2 server to deploy the updated containers

##  DockerHub Setup
- To push Docker images to DockerHub:

- Generate a DockerHub access token

- Add your credentials to GitHub as secrets:

- DOCKERHUB_USERNAME

- DOCKERHUB_PASSWORD or DOCKERHUB_TOKEN

###  SonarQube Integration (2 Options)
# Option 1: Host SonarQube Yourself (on EC2)
- Provision an EC2 instance (Amazon Linux 2 or Ubuntu)

- Install Java 17 and download SonarQube:

sudo yum update -y
sudo yum install -y java-17-amazon-corretto
cd /opt
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.4.1.88267.zip
sudo unzip sonarqube-*.zip
sudo mv sonarqube-10.4.1.88267 sonarqube

- Create a system user for Sonar:
sudo adduser sonar
sudo chown -R sonar:sonar /opt/sonarqube

- Create a systemd service:
sudo tee /etc/systemd/system/sonarqube.service <<EOF
[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=forking
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
User=sonar
Group=sonar
Restart=always
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

- sudo systemctl daemon-reload
- sudo systemctl enable sonarqube
- sudo systemctl start sonarqube

- Allow TCP port 9000 on the EC2 security group to access SonarQube's web UI.

- Get your SonarQube token from the UI (http://your-ec2-ip:9000) and store it in GitHub Secrets.

- Update GitHub Actions with:

SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
SONAR_HOST_URL: "http://<your-ec2-ip>:9000"

### Option 2: Use SonarCloud (Recommended for Public Repos)
- Visit https://sonarcloud.io

- Log in with your GitHub account

- Import your repository

- Generate a token and add it to GitHub Secrets as SONAR_TOKEN

- Use this in your workflow:

SONAR_HOST_URL: "https://sonarcloud.io"

### Deploying to EC2 from GitHub Actions
- This step uses Appleboy's SSH GitHub Action to:

- SSH into your EC2 instance using an SSH private key stored in GitHub Secrets.

- Log in to DockerHub on the EC2 machine

- Pull the updated images

- Stop old containers and spin up the new ones using Docker Compose


#ss