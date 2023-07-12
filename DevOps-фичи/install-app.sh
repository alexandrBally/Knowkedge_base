#!/bin/bash

# Обновление списка пакетов
sudo apt-get update

# Установка Nginx
sudo apt-get install -y nginx

# Установка NVM (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Перезагрузка конфигурации оболочки
source ~/.bashrc

# Установка Node.js 16
cd ~
curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh

sudo bash nodesource_setup.sh

sudo apt install nodejs

node -v

# Установка PM2
npm install pm2 -g

# Проверка версий

NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

nginx_version=$(nginx -v 2>&1 | awk -F/ '{print $2}' | awk '{print $1}')
nvm_version=$(~/.nvm/nvm.shnvm -v)
node_version=$(node -v)
pm2_version=$(pm2 -v)

echo "Version nginx: $nginx_version"
echo "Version nvm: $nvm_version"
echo "Version node: $node_version"
echo "Version pm2: $pm2_version"