# syntax=docker/dockerfile:1.4
# Using https://github.com/docker/awesome-compose/tree/master/flask
FROM python:3.10-alpine

WORKDIR /app

COPY sshd_config /etc/ssh/
COPY app.py /app
COPY entrypoint.sh /app

# Start and enable SSH
RUN apk add openssh \
    && echo "root:Docker!" | chpasswd \
    && chmod +x ./entrypoint.sh \
    && cd /etc/ssh/ \
    && ssh-keygen -A

COPY requirements.txt /app
RUN pip3 install -r requirements.txt

EXPOSE 8000 2222

ENTRYPOINT ["./entrypoint.sh"] 

