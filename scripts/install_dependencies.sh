#!/bin/bash
set -e
echo "Installing dependencies in /home/ec2-user/lms-app"
cd /home/ec2-user/lms-app || { echo "Target dir missing"; exit 1; }
# install with ci for reproducible installs
npm ci --unsafe-perm
