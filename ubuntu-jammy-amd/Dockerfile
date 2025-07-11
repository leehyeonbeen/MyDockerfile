FROM ubuntu:jammy

ENV TZ=Asia/Seoul

# Get certificate
RUN DEBIAN_FRONTEND=noninteractive apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install ca-certificates -y
# Change apt mirrors
RUN sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
RUN sed -i 's/security.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
RUN sed -i 's/ports.ubuntu.com/ftp.lanet.kr/g' /etc/apt/sources.list
# Install
RUN DEBIAN_FRONTEND=noninteractive apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install vim git wget tmux net-tools openssh-server x11-apps -y

# SSH-settings
RUN echo 'root:0000' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
EXPOSE 22

# Install miniconda
RUN mkdir -p ~/miniconda3
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
RUN bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
RUN rm -rf ~/miniconda3/miniconda.sh
RUN ~/miniconda3/bin/conda init bash

# Install CUDA Toolkit 12.8
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
RUN sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
RUN wget https://developer.download.nvidia.com/compute/cuda/12.8.0/local_installers/cuda-repo-ubuntu2204-12-8-local_12.8.0-570.86.10-1_amd64.deb
RUN sudo dpkg -i cuda-repo-ubuntu2204-12-8-local_12.8.0-570.86.10-1_amd64.deb
RUN sudo cp /var/cuda-repo-ubuntu2204-12-8-local/cuda-*-keyring.gpg /usr/share/keyrings/
RUN sudo apt-get update
RUN sudo apt-get -y install cuda-toolkit-12-8 -y

# Delete temp files
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# After build,
# docker run -itd --name test -e DISPLAY=host.docker.internal:0 -v /tmp/.X11-unix:/tmp/.X11-unix myubuntu:focal
# docker exec -it test bash
# xclock