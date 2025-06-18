# Stage 1: Build React app
FROM node:18-alpine AS build

WORKDIR /app

# 1. Copy only package files first
COPY package*.json ./

# 2. Install dependencies (build tools already included in node:alpine)
RUN npm install

# 3. Copy rest of the source code AFTER install
COPY . .

# 4. Fix permissions for react-scripts (if needed)
RUN chmod +x ./node_modules/.bin/react-scripts

# 5. Build the React app
RUN npm run build


# Stage 2: Serve with Nginx
FROM nginx:alpine

# 6. Copy built static files to Nginx html folder
COPY --from=build /app/build /usr/share/nginx/html

# 7. Copy custom Nginx config if you have one
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]











# the react was giving me issues so i changed my dockerfile
# # Use nginx to serve the static site
# FROM node:18-alpine as build

# # Set working directory
# WORKDIR /app


# # Copy files and install dependencies
# COPY package*.json ./
# RUN npm install 


# # Copy rest of the backend code
# COPY . .
# RUN npm run build

# FROM nginx:alpine
# COPY --from=build /app/build /usr/share/nginx/html
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# # Expose port 80 for web traffic
# EXPOSE 80

# # Start nginx
# CMD ["nginx", "-g", "daemon off;"]


# #In the web tier Dockerfile, i used a multi-stage build to first build the React app and then serve it using Nginx.
# # copied my nginx.cof file into mydockerfile