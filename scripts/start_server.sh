#!/bin/bash
set -e
echo "Starting application with PM2"
cd /home/ec2-user/lms-app || { echo "Target dir missing"; exit 1; }

# ensure pm2 exists; install globally if needed
if ! command -v pm2 >/dev/null 2>&1; then
  echo "pm2 not found - installing globally"
  sudo npm install -g pm2
fi

# Start or restart the app. Replace app.js if your entry is different.
pm2 describe lms >/dev/null 2>&1 && pm2 restart lms || pm2 start app.js --name lms
pm2 save
