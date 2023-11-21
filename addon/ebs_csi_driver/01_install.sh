#!/bin/bash

source ../env.sh

set -e

CSI_POLICY_NAME=AmazonEKS_EBS_CSI_Driver_Policy
# 사용자를 대신하여 CSI 드라이버 서비스 계정에서 AWS API를 호출할 수 있도록 IAM 정책을 만든다.
curl -o example-iam-policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-ebs-csi-driver/master/docs/example-iam-policy.json

POLICYARN_EXIST=$(aws iam list-policies --query 'Policies[?PolicyName==`AmazonEKS_EBS_CSI_Driver_Policy`].{ARN:Arn}' --output text | wc -l)

echo "POLICYARN_EXIST: ${POLICYARN_EXIST}"
if [ ${POLICYARN_EXIST} == 0 ];then
  echo "aws iam create-policy --policy-name ${CSI_POLICY_NAME} --policy-document file://template/example-iam-policy.json"
  aws iam create-policy \
      --policy-name ${CSI_POLICY_NAME} \
      --policy-document file://example-iam-policy.json
fi
echo "=========================================================="
echo "eksctl create iamserviceaccount --name ebs-csi-controller-sa --namespace kube-system --cluster ${EKS_CLUSTER_NAME} --attach-policy-arn arn:aws:iam::${EKS_ACCOUNT_ID}:policy/${CSI_POLICY_NAME} --approve --role-only --region ${EKS_REGION}"
# IAM 역할을 생성하고 다음 명령을 사용하여 IAM 정책을 연결할 수 있습니다
eksctl create iamserviceaccount \
    --name ebs-csi-controller-sa \
    --namespace kube-system \
    --cluster ${EKS_CLUSTER_NAME} \
    --attach-policy-arn arn:aws:iam::${EKS_ACCOUNT_ID}:policy/${CSI_POLICY_NAME} \
    --approve \
    --role-only \
    --region ${EKS_REGION}

 
 
echo "aws cloudformation describe-stacks --output json --region ${EKS_REGION} --stack-name eksctl-${EKS_CLUSTER_NAME}-addon-iamserviceaccount-kube-system-ebs-csi-controller-sa | jq '.Stacks[] | .Outputs[] | select(.OutputKey == "Role1") | .OutputValue'"
ROLE_ARN=$(aws cloudformation describe-stacks --output json --region ${EKS_REGION} --stack-name eksctl-${EKS_CLUSTER_NAME}-addon-iamserviceaccount-kube-system-ebs-csi-controller-sa | jq '.Stacks[] | .Outputs[] | select(.OutputKey == "Role1") | .OutputValue' | sed -e "s/\"//g")

echo "ROLE_ARN:${ROLE_ARN}"

echo "eksctl create addon --name aws-ebs-csi-driver --cluster ${EKS_CLUSTER_NAME} --service-account-role-arn ${ROLE_ARN} --force --region ${EKS_REGION}"
eksctl create addon --name aws-ebs-csi-driver --cluster ${EKS_CLUSTER_NAME} --service-account-role-arn ${ROLE_ARN} --force --region ${EKS_REGION}


