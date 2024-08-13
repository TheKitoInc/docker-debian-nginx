FROM kito-debian:latest

# Set environment variables
ARG DEBIAN_FRONTEND=noninteractive

# Run upgrade
RUN upgrade

# Install nginx
RUN apt-get install nginx -y

# Run nginx service
ENTRYPOINT  ["nginx", "-g", "daemon off;"]