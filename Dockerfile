# syntax=docker/dockerfile:1.4
# Using https://github.com/docker/awesome-compose/tree/master/flask
FROM python:3.10-alpine

WORKDIR /app

COPY requirements.txt /app
RUN pip3 install -r requirements.txt

RUN apt-get update \
    && apt-get install -y --no-install-recommends dialog \
    && apt-get install -y --no-install-recommends openssh-server \
    && echo "root:Docker!" | chpasswd \
    && chmod u+x ./entrypoint.sh

COPY app.py /app
COPY sshd_config /etc/ssh/

COPY entrypoint.sh /app

EXPOSE 2222

ENTRYPOINT ["./entrypoint.sh"] 

