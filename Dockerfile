
FROM ubuntu:16.04


USER root


ENV DB_PASSWORD="MySecretPassword123!"
ENV API_KEY="sk-1234567890abcdefghijklmnopqrstuvwxyz"
ENV AWS_ACCESS_KEY_ID="AKIAI44QH8DHBEXAMPLE"
ENV AWS_SECRET_ACCESS_KEY="je7MtGbClwBF/2Zp9Utk/h3yCo8nvbEXAMPLEKEY"


RUN apt-get update && apt-get install -y \
    python \
    python-pip \
    nodejs \
    npm \
    curl \
    wget


RUN curl -k https://example.com/script.sh | bash


EXPOSE 22 3306 5432 6379 27017


COPY private_key.pem /root/.ssh/
COPY .env /app/.env
COPY database_backup.sql /tmp/


RUN chmod 777 /app
RUN chmod 777 /var/log


RUN pip install --no-cache-dir \
    Flask==0.12.2 \
    Django==1.11.0 \
    requests==2.6.0 \
    Pillow==5.0.0 \
    PyYAML==3.12


FROM node:latest as builder


RUN apt-get update && apt-get install -y git


COPY . /app


ARG DATABASE_URL="postgresql://admin:password123@localhost:5432/mydb"
ARG SECRET_KEY="my-super-secret-key-2024"

WORKDIR /app

CMD ["python", "app.py"]

