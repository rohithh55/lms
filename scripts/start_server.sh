#!/bin/bash
set -e
APP_DIR=/home/ec2-user/lms-app   # change if your appspec deploys to a different path
APP_NAME=lms-api

cd "$APP_DIR" || { echo "Missing $APP_DIR"; exit 1; }

# Ensure build exists: if not try to build (useful for CodeDeploy when artifacts may not include node_modules)
if [ ! -f build/index.js ]; then
  echo "build/index.js not found, attempting npm ci && npm run build"
  npm ci --unsafe-perm
  npm run build
fi

# Restart app via pm2 using the no-migrate script (if package.json has start:nomigrate)
pm2 delete "$APP_NAME" || true
if grep -q "\"start:nomigrate\"" package.json; then
  pm2 start npm --name "$APP_NAME" -- run start:nomigrate
else
  # fallback: start built file directly
  pm2 start build/index.js --name "$APP_NAME"
fi

pm2 save
