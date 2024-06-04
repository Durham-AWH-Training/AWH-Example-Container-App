#!/bin/sh
set -e
service ssh start
exec python3 app.py