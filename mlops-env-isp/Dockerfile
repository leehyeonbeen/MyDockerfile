FROM nvidia/cuda:12.8.1-cudnn-devel-ubuntu22.04

ENV TZ=Asia/Seoul
ENV GZIP="-9"

# Get certificate
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install sudo ca-certificates -y

# Add user 'hyeonbeen'
RUN groupadd --gid 1000 defaultgroup
RUN useradd --uid 1000 --gid 1000 -m hyeonbeen
RUN echo "hyeonbeen:0000" | chpasswd
RUN echo "hyeonbeen ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER hyeonbeen
WORKDIR /home/hyeonbeen
CMD ["bash"]
SHELL ["/bin/bash", "-c"] 

# Apply Korean mirrors
RUN sudo sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
RUN sudo sed -i 's/security.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
RUN sudo sed -i 's/ports.ubuntu.com/ftp.lanet.kr/g' /etc/apt/sources.list
RUN sudo apt update && sudo apt upgrade -y

# Install applications
RUN sudo apt install curl wget vim git tmux net-tools openssh-server rsync gzip unzip bash-completion -y
RUN sudo -v ; curl https://rclone.org/install.sh | sudo bash
RUN git config --global user.name "Edward Hyeonbeen Lee"
RUN git config --global user.email "edward.hyeonbeen.lee@gmail.com"

# Install miniconda3
ENV PATH="/home/hyeonbeen/miniconda3/bin:$PATH"
ENV CONDA_PLUGINS_AUTO_ACCEPT_TOS=true
RUN cd
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash ~/Miniconda3-latest-Linux-x86_64.sh -b
RUN rm -rf ~/Miniconda3-latest-Linux-x86_64.sh
RUN source ~/miniconda3/bin/activate
RUN conda init --all
RUN conda install -c conda-forge conda-bash-completion -y

# tmux auto-completion
RUN curl -fSsL "https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/master/completions/tmux" > ~/.bash.tmux-bash-completion
RUN echo 'source ~/.bash.tmux-bash-completion' >> ~/.bashrc
RUN source ~/.bashrc
# tmux config
RUN echo "set -g mouse on" >> ~/.tmux.conf
RUN echo "set -g history-limit 1000000" >> ~/.tmux.conf
RUN echo "set -g @scroll-speed-num-lines-per-scroll 1" >> ~/.tmux.conf
RUN touch ~/.no_auto_tmux

# Cleanup caches
RUN sudo apt autoremove
RUN sudo apt clean
RUN sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*