#!/bin/sh
set -e
/usr/sbin/sshd
exec python3 app.py