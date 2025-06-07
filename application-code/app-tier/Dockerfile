# Base image for Node.js
FROM node:18-alpine

# 18-alpine
# Set working directory
WORKDIR /app


# Copy files and install dependencies
COPY package*.json ./
RUN npm install

# Copy rest of the backend code
COPY . .
RUN npm build

# Expose backend port
EXPOSE 4000

# Run the server
CMD ["npm", "start"]



