# Base image for Node.js
FROM node:16

# 18-alpine
# Set working directory
WORKDIR /app

# Install wait-for-it and dependencies
RUN apt-get update && apt-get install -y netcat
COPY wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

# Copy files and install dependencies
COPY package*.json ./
RUN npm install

# Copy rest of the backend code
COPY . .

# Expose backend port
EXPOSE 4000

# Run the server
CMD ["./wait-for-it.sh", "db:3306", "--", "node", "index.js"]



