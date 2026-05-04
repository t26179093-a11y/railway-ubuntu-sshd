FROM ubuntu:22.04

# 1. SSH Server und Sudo installieren
RUN apt-get update && apt-get install -y openssh-server sudo

# 2. Notwendigen Ordner für den SSH-Dienst anlegen
RUN mkdir -p /run/sshd

# 3. Einen echten Benutzer anlegen (Benutzer: myuser | Passwort: mypassword)
RUN useradd -rm -d /home/myuser -s /bin/bash -g root -G sudo -u 1000 myuser
RUN echo 'myuser:mypassword' | chpasswd

# 4. SSH-Server konfigurieren
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN echo "PermitRootLogin no" >> /etc/ssh/sshd_config

# 5. Port freigeben
EXPOSE 22

# 6. CRITICAL: sshd im Vordergrund laufen lassen, damit Railway nicht beendet!
CMD ["/usr/sbin/sshd", "-D"]
