FROM ubuntu:latest

USER root

# Install Nginx
RUN apt-get update && apt-get install -y nginx tcpdump curl

# Copy your Nginx configuration and website files
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /var/www/html/index.html

# Add a health check command
HEALTHCHECK CMD curl -f http://localhost/ || exit 1

# Expose port 80 for Nginx
EXPOSE 80

# Command to start Nginx and run tcpdump
CMD sh -c "nginx -g 'daemon off;' & tcpdump -i eth0 udp port 80"