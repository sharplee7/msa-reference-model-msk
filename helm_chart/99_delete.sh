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

if [ ! -f "${PROGRAM}/custom-values.yaml" ];then
  echo "${PROGRAM}/custom-values.yaml is not exist"
  exit 1;
fi

. ${PROGRAM}/env.sh

echo ">> kubectl delete namespace ${PACKAGE_NAME}-ns"
kubectl delete namespace ${PACKAGE_NAME}-ns
