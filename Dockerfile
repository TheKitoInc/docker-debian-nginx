FROM kito-debian:latest

# Set environment variables
ARG DEBIAN_FRONTEND=noninteractive

# Run upgrade
RUN upgrade

# Install nginx
RUN apt-get install nginx -y

# Create directories
RUN mkdir -p /etc/nginx/services-enabled

# Create main nginx.conf
RUN cat /dev/null > /etc/nginx/nginx.conf
RUN echo "user www-data;" >> /etc/nginx/nginx.conf
RUN echo "worker_processes auto;" >> /etc/nginx/nginx.conf
RUN echo "pid /run/nginx.pid;" >> /etc/nginx/nginx.conf
RUN echo "error_log /var/log/nginx/error.log;" >> /etc/nginx/nginx.conf
RUN echo "include /etc/nginx/modules-enabled/*.conf;" >> /etc/nginx/nginx.conf
RUN echo "include /etc/nginx/services-enabled/*.conf;" >> /etc/nginx/nginx.conf

RUN echo "events {" >> /etc/nginx/nginx.conf
RUN echo "        worker_connections 768;" >> /etc/nginx/nginx.conf
RUN echo "        # multi_accept on;" >> /etc/nginx/nginx.conf
RUN echo "}" >> /etc/nginx/nginx.conf

# Create snippet robots.conf
RUN cat /dev/null > /etc/nginx/snippets/robots.conf
RUN echo "location /robots.txt {" >> /etc/nginx/snippets/robots.conf
RUN echo "        add_header Content-Type text/plain;" >> /etc/nginx/snippets/robots.conf
RUN echo "        return 200 \"User-agent: *\nDisallow: /\n\";" >> /etc/nginx/snippets/robots.conf
RUN echo "}" >> /etc/nginx/snippets/robots.conf
# Run nginx service
ENTRYPOINT  ["nginx", "-g", "daemon off;"]