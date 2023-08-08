#!/usr/bin/env bash

case "$(lscpu | grep Architecture | awk '{print $2}')" in
aarch64)
        CPU_ARCH=aarch64
        ;;
x86_64)
        CPU_ARCH=x64
        ;;
esac
MC_VERSION=1.20.1
FABCIC_VERSION=0.14.22
INSTALLER_VERSION=0.11.2
FABRIC_URL=https://meta.fabricmc.net/v2/versions/loader/${MC_VERSION}/${FABCIC_VERSION}/${INSTALLER_VERSION}/server/jar
JAVA_TAR=openjdk-17.0.2_linux-${CPU_ARCH}_bin.tar.gz
JAVA_URL=https://download.java.net/java/GA/jdk17.0.2/dfd4a8d0985749f896bed50d7138ee7f/8/GPL/${JAVA_TAR}
JAVA_PATH=jre/jdk-17.0.2/bin/java
JAR_NAME=fabric-server-mc.${MC_VERSION}-loader.${FABCIC_VERSION}-launcher.${INSTALLER_VERSION}.jar
XMS=4G
XMX=12G

if [ ! -f $JAVA_PATH ]
then
        echo "Downloading OpenJDK 17..."
        curl -s $JAVA_URL -o $JAVA_TAR
        if [ ! -d jre ]
        then
                mkdir jre
        fi
        tar xf $JAVA_TAR -C jre
        rm $JAVA_TAR
fi

if [ ! -f $JAR_NAME ]
then
        echo "Downloading Fabric..."
        curl -OJ $FABRIC_URL
fi

if [ -z $(grep "eula=true" eula.txt 2>/dev/null) ]
then
        echo "Accepting EULA..."
        echo "eula=true" | tee eula.txt > /dev/null
fi

$JAVA_PATH -Xms$XMS -Xmx$XMX -jar $JAR_NAME nogui