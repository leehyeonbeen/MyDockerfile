#!/bin/bash

# Get certificate
DEBIAN_FRONTEND=noninteractive apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install ca-certificates -y

# Change apt mirrors
# sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
# sed -i 's/security.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
# sed -i 's/ports.ubuntu.com/ftp.lanet.kr/g' /etc/apt/sources.list

# Install
DEBIAN_FRONTEND=noninteractive apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install vim git wget tmux net-tools openssh-server gh -y

# tmux setup
echo "set -g mouse on" >> /root/.tmux.conf
touch ~/.no_auto_tmux

# SSH-settings
echo 'root:0000' | chpasswd
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Install miniconda
# mkdir -p ~/miniconda3
# wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
# bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
# rm -rf ~/miniconda3/miniconda.sh
# ~/miniconda3/bin/conda init bash

# Delete temp files
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# After build,
# docker -itd --name test -e DISPLAY=host.docker.internal:0 -v /tmp/.X11-unix:/tmp/.X11-unix myubuntu:focal
# docker exec -it test bash
# xclock