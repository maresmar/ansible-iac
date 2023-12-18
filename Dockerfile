FROM ubuntu:22.04
RUN apt update -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false && apt install -y openssh-server
# Configure SSH
RUN mkdir /var/run/sshd
ARG ROOT_PASSWORD
RUN echo "root:$ROOT_PASSWORD" | chpasswd
#password for user login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
EXPOSE 22
# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]
