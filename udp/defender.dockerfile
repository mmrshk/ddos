FROM ubuntu:latest

USER root

# Install Nginx
RUN apt-get update && apt-get install -y nginx iptables sudo tcpdump net-tools

# Copy your Nginx configuration and website files
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /var/www/html/index.html

# Expose port 80 for Nginx
EXPOSE 80

# Command to start Nginx
CMD ["nginx", "-g", "daemon off;"]
CMD service nginx start && tcpdump -i eth0 udp port 80
