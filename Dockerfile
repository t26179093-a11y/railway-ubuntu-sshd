FROM hopingboyz/ubuntu22.04

# Falls das Image nicht bereits alles hat, hier die SSH-Konfiguration:
RUN apt-get update && apt-get install -y openssh-server sudo \
    && mkdir -p /run/sshd \
    && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
    && echo "PermitRootLogin no" >> /etc/ssh/sshd_config

COPY ssh-user-config.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/ssh-user-config.sh

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

