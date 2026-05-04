FROM hopingboyz/ubuntu22.04

# 1. SSH Server und Sudo installieren
RUN apt-get update && apt-get install -y openssh-server sudo

# 2. Notwendige Ordner für den SSH-Dienst erstellen
RUN mkdir -p /run/sshd

# 3. Einen neuen Benutzer (z.B. "myuser") mit dem Passwort "mypassword" erstellen
RUN useradd -rm -d /home/myuser -s /bin/bash -g root -G sudo -u 1000 myuser
RUN echo 'myuser:mypassword' | chpasswd

# 4. SSH-Server für Passwort-Login konfigurieren
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN echo "PermitRootLogin no" >> /etc/ssh/sshd_config

# 5. Port 22 für Railway freigeben
EXPOSE 22

# 6. Den SSH-Dienst im Vordergrund starten, damit der Container nicht stoppt!
CMD ["/usr/sbin/sshd", "-D"]
