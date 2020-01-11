FROM ubuntu:18.04

RUN apt-get update && apt-get install -y openssh-server sudo bash-completion
RUN mkdir /run/sshd
RUN useradd -m -s /bin/bash ubuntu && gpasswd -a ubuntu sudo
RUN echo 'ubuntu:secret' | chpasswd

# For X11Forwarding
RUN apt-get install -y xauth
RUN echo AddressFamily inet >> /etc/ssh/sshd_config

COPY --chown=ubuntu:ubuntu authorized_keys /home/ubuntu/.ssh/authorized_keys

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
