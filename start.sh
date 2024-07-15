#!/usr/bin/env bash

MC_VERSION=1.20.1
FABCIC_VERSION=0.15.5
INSTALLER_VERSION=1.0.0
JAVA_VERSION=17

JAVA_PATH=jre/bin/java
JAR_NAME=fabric-server-mc.${MC_VERSION}-loader.${FABCIC_VERSION}-launcher.${INSTALLER_VERSION}.jar

XMS=4G
XMX=12G

if [ ! -f $JAVA_PATH ]
then
        echo "Downloading Adoptium JRE ${JAVA_VERSION}..."
        case "$(lscpu | grep Architecture | awk '{print $2}')" in
        aarch64)
                CPU_ARCH=aarch64
                ;;
        x86_64)
                CPU_ARCH=x64
                ;;
        esac
        JAVA_TAR=jre.tar.gz        
        JAVA_URL=https://api.adoptium.net/v3/binary/latest/${JAVA_VERSION}/ga/linux/${CPU_ARCH}/jre/hotspot/normal/eclipse
        curl -sL $JAVA_URL -o $JAVA_TAR
        [[ ! -d jre ]] && mkdir jre
        tar xf $JAVA_TAR -C jre --strip-components=1
        rm $JAVA_TAR
fi

if [ ! -f $JAR_NAME ]
then
        echo "Downloading Fabric..."
        FABRIC_URL=https://meta.fabricmc.net/v2/versions/loader/${MC_VERSION}/${FABCIC_VERSION}/${INSTALLER_VERSION}/server/jar
        curl -sOJ $FABRIC_URL
fi

if [ -z $(grep "eula=true" eula.txt 2>/dev/null) ]
then
        echo "Accepting EULA..."
        echo "eula=true" > eula.txt
fi

$JAVA_PATH -Xms$XMS -Xmx$XMX -jar $JAR_NAME nogui
