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

# Copiar el script de inicialización al contenedor
COPY ./src/init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

# Configurar hostname
RUN echo "solvet-it.com.py" > /etc/hostname

# Mantener el contenedor iniciado
CMD ["/usr/local/bin/init.sh"]