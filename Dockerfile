# Using outdated base image with known vulnerabilities
FROM ubuntu:16.04

# Running as root user (security issue)
USER root

# Hardcoded secrets in environment variables
ENV DB_PASSWORD="MySecretPassword123!"
ENV API_KEY="sk-1234567890abcdefghijklmnopqrstuvwxyz"
ENV AWS_ACCESS_KEY_ID="AKIAI44QH8DHBEXAMPLE"
ENV AWS_SECRET_ACCESS_KEY="je7MtGbClwBF/2Zp9Utk/h3yCo8nvbEXAMPLEKEY"

# Installing packages without specifying versions
RUN apt-get update && apt-get install -y \
    python \
    python-pip \
    nodejs \
    npm \
    curl \
    wget

# Using curl with insecure flag
RUN curl -k https://example.com/script.sh | bash

# Exposing unnecessary ports
EXPOSE 22 3306 5432 6379 27017

# Adding sensitive files to image
COPY private_key.pem /root/.ssh/
COPY .env /app/.env
COPY database_backup.sql /tmp/

# Running commands as root
RUN chmod 777 /app
RUN chmod 777 /var/log

# Installing vulnerable Python packages
RUN pip install --no-cache-dir \
    Flask==0.12.2 \
    Django==1.11.0 \
    requests==2.6.0 \
    Pillow==5.0.0 \
    PyYAML==3.12

# No healthcheck defined
# HEALTHCHECK NONE

# Using latest tag (unpredictable)
FROM node:latest as builder

# Not cleaning up apt cache (larger image size)
RUN apt-get update && apt-get install -y git

# Copying entire directory including sensitive files
COPY . /app

# Hardcoded credentials in build args
ARG DATABASE_URL="postgresql://admin:password123@localhost:5432/mydb"
ARG SECRET_KEY="my-super-secret-key-2024"

WORKDIR /app

# Running application as root
CMD ["python", "app.py"]

# No USER instruction - running as root
# Missing security best practices:
# - No image scanning
# - No minimal base image (alpine)
# - No multi-stage build cleanup
# - Sensitive data in layers
# - No read-only root filesystem
# - No resource limits
