#!/bin/bash
echo "Pulling actual version..."
git pull origin dev
source /home/boomerang/.nvm/nvm.sh
echo "nvm changed"
echo "Building app..."
npm run build
source /home/boomerang/.nvm/nvm.sh
pm2 delete boomerang-backend
pm2 start ecosystem.config.js