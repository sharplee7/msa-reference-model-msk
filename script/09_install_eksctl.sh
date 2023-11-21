#!/bin/bash

EKSCTL_VERSION=v0.102.0
curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/${EKSCTL_VERSION}/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
if [ ! -d "$HOME/bin" ];then
  mkdir $HOME/bin
fi
sudo mv /tmp/eksctl $HOME/bin
eksctl version

