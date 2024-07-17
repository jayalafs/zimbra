#!/bin/bash

# Configurar /etc/hosts
echo "127.0.0.1 localhost" > /etc/hosts
echo "172.25.2.1 solvet-it.com.py mail.solvet-it.com.py" >> /etc/hosts

# Configuración de dominio
cat > /etc/dnsmasq.conf << EOF
listen-address=127.0.0.1
interface=eth0
expand-hosts
domain=solvet-it.com.py
server=4.2.2.1
server=4.2.2.2
address=/.solvet-it.com.py/127.0.0.1
address=/.solvet-it.com.py/181.94.220.180
mx-host=solvet-it.com.py,mail.solvet-it.com.py,1
addn-hosts=/etc/hosts
cache-size=9500
EOF

# Parar y desactivar systemd-resolved
service systemd-resolved stop
systemctl disable systemd-resolved

# Configurar /etc/resolv.conf
echo "nameserver 127.0.0.1" > /etc/resolv.conf

# Iniciar dnsmasq
service dnsmasq start

# Descargar e instalar Zimbra
#cd /tmp
#wget https://files.zimbra.com/downloads/8.8.15_GA/zcs-8.8.15_GA_3869.UBUNTU18_64.20200331034305.tgz
#tar xzvf zcs-8.8.15_GA_3869.UBUNTU18_64.20200331034305.tgz
#cd zcs-8.8.15_GA_3869.UBUNTU18_64.20200331034305
#./install.sh -s # La opción -s es para configuración sin interacción

# Configurar Zimbra según tus necesidades
# Aquí puedes agregar comandos adicionales para configuración personalizada

# Mantener el contenedor en ejecución
tail -f /dev/null