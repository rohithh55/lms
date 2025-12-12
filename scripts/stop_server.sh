#!/bin/bash
set -e
echo "Stopping PM2 app if running"
# pm2 may be installed at /usr/bin/pm2; try both
if command -v pm2 >/dev/null 2>&1; then
  pm2 stop lms || pm2 stop all || true
else
  echo "pm2 not found - nothing to stop"
fi
