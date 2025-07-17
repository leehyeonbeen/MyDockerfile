#!/bin/bash

# Delete venv
sudo rm -rf .venv/ /home/jovyan_venv/ # delete venv directories
sed -i '/\.venv/d' ~/.bashrc # delete relevant lines in ~/.bashrc

# Install miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash ~/Miniconda3-latest-Linux-x86_64.sh
rm -rf ~/Miniconda3-latest-Linux-x86_64.sh
source ~/.bashrc

# Install applications
sudo sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
sudo sed -i 's/security.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
sudo sed -i 's/ports.ubuntu.com/ftp.lanet.kr/g' /etc/apt/sources.list
sudo apt update && sudo apt upgrade -y
sudo apt install ca-certificates curl wget vim git tmux net-tools openssh-server rsync -y
sudo -v ; curl https://rclone.org/install.sh | sudo bash

# Setup tmux
echo "set -g mouse on" >> ~/.tmux.conf
echo "set -g history-limit 1000000" >> ~/.tmux.conf
echo "set -g @scroll-speed-num-lines-per-scroll 1" >> ~/.tmux.conf

# Cleanup caches
sudo apt autoremove
sudo apt clean
sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*