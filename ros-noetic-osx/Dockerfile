# docker build --tag myros:noetic --platform linux/amd64 --no-cache=true .

FROM osrf/ros:noetic-desktop-full
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
# RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install vim git wget tmux net-tools openssh-server x11-apps -y
# Install ROS
# RUN DEBIAN_FRONTEND=noninteractive apt-get install cmake-curses-gui -y
# RUN DEBIAN_FRONTEND=noninteractive apt-get install ros-noetic-desktop-full -y
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
# RUN DEBIAN_FRONTEND=noninteractive apt-get install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential -y
# RUN DEBIAN_FRONTEND=noninteractive apt-get install python3-rosdep -y
# RUN rosdep init && rosdep update

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

# Delete temp files
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# After build,
# docker run -itd --name myros -e DISPLAY=host.docker.internal:0 -v /tmp/.X11-unix:/tmp/.X11-unix --platform linux/amd64 -p 77:22 myros:noetic
# docker exec -it myros bash
# xclock