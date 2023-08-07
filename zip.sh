#!/usr/bin/env bash

zip server.zip ./* -x $(cat .gitignore | xargs) README.md zip.sh @