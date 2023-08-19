#!/usr/bin/env bash

rm -f server.zip
zip -r server.zip ./* -x $(cat .gitignore | xargs) README.md zip.sh @
