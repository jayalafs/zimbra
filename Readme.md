# Instalación de Zimbra utilizando Docker

Este documento detalla los pasos necesarios para la compilacion de y posterior instalacion de zimbra 10 utilizando docker

## Autor

- Nombre: Jose Ayala
- Correo: jayala@solvet-it.com.py

Referencias
https://wiki.vidalinux.org/index.php/Howto_zimbra#compile_zimbra
https://hub.docker.com/r/ovox/zimbrabuild-ubuntu20

## Prerrequisitos

Antes de comenzar, asegúrate de tener instalados los siguientes componentes:

- Docker
- Docker-compose
- Git
- Githut

## Creación de Directorios

Primero, necesitamos crear los directorios necesarios para almacenar las claves SSH y otros volúmenes requeridos.

```bash
mkdir -p ~/ubuntu20/ssh ~/ubuntu20/volumen

## Generacion de clave RSA
ssh-keygen -t rsa -b 4096 -C "jayala@solvet-it.com.py" -f ~/ubuntu20/ssh/id_rsa

## Alzamos la clave
https://github.com/settings/keys

## Prueba de clave
chmod 700 ~/ubuntu20/ssh/id_rsa
ssh -T git@github.com -i ~/ubuntu20/ssh/id_rsa

## Compilacion de la imagen
cd ~/ubuntu20

docker run --rm --name "zimbrabuild_ubuntu20" \
-v $PWD/volume:/home/git/BUILDS \
-v $PWD/ssh:/root/.ssh \
-e BUILD_NO="0001" \
-e BUILD_RELEASE="DAFFODIL" \
-e BUILD_RELEASE_NO="10.0.6" \
-e BUILD_OS="UBUNTU20_64" \
-e BUILD_ARCH="amd64" \
-e BUILD_TYPE="FOSS" \
-e PKG_OS_TAG="u20" \
-e BUILD_RELEASE_CANDIDATE="GA" \
-e BUILD_THIRDPARTY_SERVER="archivos .zimbra.com" \
-e INTERACTIVE="0" \
docker.io/ovox/zimbrabuild-ubuntu20:latest
