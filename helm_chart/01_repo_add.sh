#!/bin/bash

if [ "$#" != 1 ];then
  echo "Usage: ./01_repo_add.sh [program]"
  exit 1;
fi
PROGRAM=$1

if [ ! -d "${PROGRAM}" ];then
  echo "Usage: ./01_repo_add.sh [program]"
  exit 1;
fi

if [ ! -f "${PROGRAM}/env.sh" ];then
  echo "${PROGRAM}/env.sh is not exist"
  exit 1;
fi

. ${PROGRAM}/env.sh

echo ">> helm repo add ${REPO_NAME} ${REPO_SITE}"
echo ">> helm repo update"
helm repo add ${REPO_NAME} ${REPO_SITE}
helm repo update