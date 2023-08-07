#!/usr/bin/env bash

MC_VERSION=1.18.2
FABCIC_VERSION=0.14.22
INSTALLER_VERSION=0.11.2
FABRIC_URL=https://meta.fabricmc.net/v2/versions/loader/$MC_VERSION/$FABCIC_VERSION/$INSTALLER_VERSION/server/jar
JAVA_PATH=
JAR_NAME=fabric-server-mc.$MC_VERSION-loader.$FABCIC_VERSION-launcher.$INSTALLER_VERSION.jar
XMS=4G
XMX=12G


if [ ! -f $JAR_NAME ]
then
	curl -OJ $FABRIC_URL
fi

if [ ! grep "eula=true" eula.txt ]
then
	echo "eula=true" | tee eula.txt > /dev/null
fi

$JAVA -Xms$XMS -Xmx$XMX -jar $JAR_NAME nogui