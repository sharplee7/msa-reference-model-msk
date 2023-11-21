#!/usr/bin/env bash

source ../env.sh

## 서비스 어카운트 생성
eksctl create iamserviceaccount \
    --name xray-daemon \
    --namespace default \
    --cluster ${EKS_CLUSTER_NAME} \
    --attach-policy-arn arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess \
    --approve \
    --override-existing-serviceaccounts

## 서비스 어카운트에 Label 생성
kubectl label serviceaccount xray-daemon app=xray-daemon

## daemonset 생성
kubectl create -f https://raw.githubusercontent.com/whchoi98/myeks/master/xray-k8s-daemonset.yaml

## X-Ray 데몬셋 상태 확인
kubectl describe daemonset xray-daemon

## pod 로그 확인
kubectl logs -l app=xray-daemon

## application 배포
curl -LO https://eksworkshop.com/intermediate/245_x-ray/sample-front.files/x-ray-sample-front-k8s.yml

## annotation 추가
## metadata:
##  name: x-ray-sample-front-k8s
##  annotations:
##    service.beta.kubernetes.io/aws-load-balancer-type: "nlb"
##    service.beta.kubernetes.io/aws-load-balancer-subnets: subnet-095f75c4747bfa958,subnet-0b7f55d5d2d469ba3,subnet-0ad4984e4ff928bf1
##    service.beta.kubernetes.io/aws-load-balancer-scheme: "internet-facing"
##

kubectl apply -f https://eksworkshop.com/intermediate/245_x-ray/sample-back.files/x-ray-sample-back-k8s.yml

## 배포 상태 확인
kubectl describe deployments x-ray-sample-front-k8s x-ray-sample-back-k8s

