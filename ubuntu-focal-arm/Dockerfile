# Tested on M1 MacBook Pro running OSX Ventura 13.6 with Docker Desktop 4.24.2 and XQuartz 2.8.5
# Build by running:
# docker build -t myubuntu:focal --no-cache=true .

FROM ubuntu:focal

# Prevent questions during command runs
ENV DEBIAN_FRONTEND=noninteractive
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone

# Get certificate
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install sudo ca-certificates tzdata -y
# Change apt mirrors
RUN sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
RUN sed -i 's/security.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
RUN sed -i 's/ports.ubuntu.com/ftp.lanet.kr/g' /etc/apt/sources.list

# Install
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install vim git wget tmux net-tools openssh-server x11-apps -y

# Setup SSH
EXPOSE 22
RUN ssh-keygen -A
RUN  mkdir /var/run/sshd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
CMD ["/usr/sbin/sshd", "-D"]

# Install miniconda
RUN mkdir -p ~/miniconda3
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh -O ~/miniconda3/miniconda.sh
RUN bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
RUN rm -rf ~/miniconda3/miniconda.sh
RUN ~/miniconda3/bin/conda init bash

# Install XRDP
RUN DEBIAN_FRONTEND=noninteractive apt-get install xrdp xfce4 xfce4-session xfce4-terminal -y
RUN sed -i 's/#AllowRootLogin=false/AllowRootLogin=true/' /etc/xrdp/sesman.ini
RUN systemctl enable xrdp
RUN adduser xrdp ssl-cert
RUN echo xfce4-session >~/.xsession
RUN echo unset DBUS_SESSION_BUS_ADDRESS >>/etc/xrdp/startwm.sh
RUN echo unset XDG_RUNTIME_DIR >>/etc/xrdp/startwm.sh
RUN echo . $HOME/.profile >>/etc/xrdp/startwm.sh
RUN echo exec /bin/sh /etc/X11/Xsession >>/etc/xrdp/startwm.sh
RUN service xrdp restart
RUN xrdp

# Install Firefox
RUN DEBIAN_FRONTEND=noninteractive apt-get install chromium-browser -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install firefox -y

# Install VSCode
RUN DEBIAN_FRONTEND=noninteractive apt-get install wget gpg -y
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
RUN install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
RUN sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
RUN rm -f packages.microsoft.gpg
RUN DEBIAN_FRONTEND=noninteractive apt install apt-transport-https -y
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install code -y
RUN sed -i '/^#!.*/a set -- "$@" "--no-sandbox" "--user-data-dir=~"' /usr/bin/code
RUN sed -i '/^ELECTRON=.*/i VSCODE_PATH="/usr/share/code"' /usr/bin/code
RUN sed -i 's!/code !&--no-sandbox --user-data-dir=~ !' /usr/share/applications/code.desktop

# Delete temp files
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set passwords and user
RUN echo 'root:0000' | chpasswd
# RUN useradd -m hyeonbeen
# RUN usermod -aG sudo hyeonbeen
# RUN echo "hyeonbeen" | sudo -S chmod 777 /home
# RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
# RUN echo 'hyeonbeen:0000' | chpasswd

# After build, run container by:
# docker run -itd --name test -e DISPLAY=host.docker.internal:0 -v /tmp/.X11-unix:/tmp/.X11-unix -p 3389:3389 -p 33:22 myubuntu:focal
# docker exec -it test bash

# Connect using RDP client
# service xrdp restart
# Address: localhost:3389
# Username: root 
# PW: 0000

# Connect SSH
# Address: localhost:33
# Username: root 
# PW: 0000