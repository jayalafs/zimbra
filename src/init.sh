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
address=/.solvet-it.com.py/192.168.24.45
mx-host=solvet-it.com.py,mail.solvet-it.com.py,1
addn-hosts=/etc/hosts
cache-size=9500
EOF

# Configurar /etc/resolv.conf
echo "nameserver 127.0.0.1" > /etc/resolv.conf

# Mantener el contenedor en ejecución
sleep infinity