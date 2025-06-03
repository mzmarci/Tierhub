# Use nginx to serve the static site
FROM nginx:alpine

# Copy your built frontend files to the nginx html directory
COPY . /usr/share/nginx/html

# Expose port 80 for web traffic
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
