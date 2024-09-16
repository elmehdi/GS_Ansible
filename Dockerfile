FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    openssh-server \
    && mkdir /var/run/sshd

# Create a user "ansible_user"
RUN useradd -m -s /bin/bash ansible_user \
    && echo "ansible_user:password" | chpasswd

# Allow password authentication and root login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && echo "AllowUsers ansible_user" >> /etc/ssh/sshd_config

EXPOSE 22

# Start the SSH server
CMD ["/usr/sbin/sshd", "-D"]

