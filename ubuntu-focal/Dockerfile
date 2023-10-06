FROM ubuntu:focal

ENV TZ=Asia/Seoul

# Change apt mirrors
RUN sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
RUN sed -i 's/security.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
# RUN sed -i 's/ports.ubuntu.com/ftp.lanet.kr/g' /etc/apt/sources.list

# Get updates
RUN apt update -y && apt upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt install vim git wget curl tmux net-tools openssh-server x11-apps -y

# SSH-settings
RUN mkdir /var/run/sshd
RUN echo 'root:7941' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

# Install miniconda
RUN mkdir -p ~/miniconda3
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh -O ~/miniconda3/miniconda.sh
RUN bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
RUN rm -rf ~/miniconda3/miniconda.sh
RUN ~/miniconda3/bin/conda init bash

# Delete temp files
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
