# Dockerfile
FROM ubuntu:jammy

# Configurar las variables de entorno para la instalación no interactiva
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Asuncion

# Actualizar el sistema e instalar paquetes necesarios
RUN apt-get update && \
    apt-get install -y \
    sqlite3 \
    bind9-dnsutils \
    perl \
    perl-base \
    perl-modules \
    nano \
    sudo \
    libpcre3 \
    libgmp10 \
    unzip \
    libgmp3-dev \
    sysstat \
    libexpat1 \
    wget \
    language-pack-en \
    libaio1 \
    pax \
    dnsmasq \
    net-tools && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Configurar hostname
RUN echo "solvet-it.com.py" > /etc/hostname

# Configuración /etc/hosts
RUN echo "127.0.0.1 localhost" > /etc/hosts && \
    echo "172.25.2.1 solvet-it.com.py mail.solvet-it.com.py" >> /etc/hosts

# Configuración de dominio
RUN echo "listen-address=127.0.0.1" > /etc/dnsmasq.conf && \
    echo "interface=eth0" >> /etc/dnsmasq.conf && \
    echo "expand-hosts" >> /etc/dnsmasq.conf && \
    echo "domain=solvet-it.com.py" >> /etc/dnsmasq.conf && \
    echo "server=4.2.2.1" >> /etc/dnsmasq.conf && \
    echo "server=4.2.2.2" >> /etc/dnsmasq.conf && \
    echo "address=/.solvet-it.com.py/127.0.0.1" >> /etc/dnsmasq.conf && \
    echo "address=/.solvet-it.com.py/192.168.24.45" >> /etc/dnsmasq.conf && \
    echo "mx-host=solvet-it.com.py,mail.solvet-it.com.py,1" >> /etc/dnsmasq.conf && \
    echo "addn-hosts=/etc/hosts" >> /etc/dnsmasq.conf && \
    echo "cache-size=9500" >> /etc/dnsmasq.conf

# Desactivar systemd-resolved y activar dnsmasq
RUN systemctl stop systemd-resolved.service && \
    systemctl disable systemd-resolved.service && \
    systemctl enable dnsmasq.service && \
    systemctl start dnsmasq.service

# Configuración /etc/resolv.conf
RUN echo "nameserver 127.0.0.1" > /etc/resolv.conf

# Mantener el contenedor iniciado
CMD ["sleep", "infinity"]