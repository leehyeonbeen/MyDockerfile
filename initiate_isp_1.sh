#!/bin/bash

# Apply Korean mirrors
sudo sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
sudo sed -i 's/security.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
sudo sed -i 's/ports.ubuntu.com/ftp.lanet.kr/g' /etc/apt/sources.list
sudo apt update && sudo apt upgrade -y

# Set timezone and sync
sudo apt install ntpdate -y
sudo ntpdate time.google.com
sudo ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# Delete venv
sudo rm -rf .venv/ /home/jovyan_venv/ # delete venv directories
sed -i '/\.venv/d' ~/.bashrc # delete relevant lines in ~/.bashrc

# Install miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash ~/hyeonbeen-vol/Miniconda3-latest-Linux-x86_64.sh
rm -rf ~/hyeonbeen-vol/Miniconda3-latest-Linux-x86_64.sh
source ~/miniconda3/bin/activate
conda init --all

# Install applications
sudo apt install curl wget vim git tmux net-tools openssh-server rsync gzip unzip bash-completion -y
sudo -v ; curl https://rclone.org/install.sh | sudo bash
git config --global user.name "Edward Hyeonbeen Lee"
git config --global user.email "edward.hyeonbeen.lee@gmail.com"
echo 'export GZIP="-9"' >> ~/.bashrc

# tmux auto-completion
curl -fSsL "https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/master/completions/tmux" > ~/.bash.tmux-bash-completion
echo 'source ~/.bash.tmux-bash-completion' >> ~/.bashrc
# tmux config
echo "set -g mouse on" >> ~/.tmux.conf
echo "set -g history-limit 1000000" >> ~/.tmux.conf
echo "set -g @scroll-speed-num-lines-per-scroll 1" >> ~/.tmux.conf

# Cleanup caches
sudo apt autoremove
sudo apt clean
sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*