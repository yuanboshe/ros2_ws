#!/bin/bash

# 环境变量
cd "$(dirname "$0")" || exit $?
WORK_PATH=$(pwd)

# Add goin-aicrobo_ros2_ws command to /usr/local/bin/
sudo cp ./scripts/goin-aicrobo_ros2_ws.sh /usr/local/bin/goin-aicrobo_ros2_ws

# Deploy folders
mkdir src

# Install vscode
sudo wget http://vscode.cdn.azure.cn/stable/5554b12acf27056905806867f251c859323ff7e9/code_1.64.0-1643863948_amd64.deb -O /tmp/vscode.deb
sudo apt install /tmp/vscode.deb
sudo rm -rf /tmp/vscode.deb

# Install docker
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce -y

# Grant docker
sudo groupadd docker
sudo gpasswd -a $USER docker
echo "请重启计算机，以便docker权限生效！"
newgrp docker
