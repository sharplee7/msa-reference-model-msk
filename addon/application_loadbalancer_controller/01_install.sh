#!/bin/bash

source ../env.sh

# AWS 로드 밸런서 컨트롤러의 IAM 정책 생성 ( 1.27 )
curl -o load-balancer-role-trust-policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/install/iam_policy.json

POLICYARN_EXIST=$(aws iam list-policies --query 'Policies[?PolicyName==`AWSLoadBalancerControllerIAMPolicy`].{ARN:Arn}' --output text | wc -l)
LB_CONTROLLER_POLICY_NAME="AWSLoadBalancerControllerIAMPolicy"
echo "POLICYARN_EXIST: ${POLICYARN_EXIST}"
if [ ${POLICYARN_EXIST} == 0 ];then
  echo "aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://iam_policy.json"
  aws iam create-policy \
    --policy-name ${LB_CONTROLLER_POLICY_NAME} \
    --policy-document file://load-balancer-role-trust-policy.json
fi

# Kubernetes 서비스 계정 추가
echo "eksctl create iamserviceaccount start"
eksctl create iamserviceaccount \
  --cluster=${EKS_CLUSTER_NAME} \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --attach-policy-arn=arn:aws:iam::${EKS_ACCOUNT_ID}:policy/${LB_CONTROLLER_POLICY_NAME} \
  --region ${EKS_REGION} \
  --override-existing-serviceaccounts \
  --approve
echo "eksctl create iamserviceaccount end"
# ingress controller가 설치되어 있다면 삭제한다.
CONTROLLER_INSTALLED=$(kubectl get deployment -n kube-system alb-ingress-controller 2>&1 | grep "Error from server (NotFound)" | wc -l)

if [ ${CONTROLLER_INSTALLED} != 1 ];then
#   kubectl delete -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.8/docs/examples/alb-ingress-controller.yaml
#   kubectl delete -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.8/docs/examples/rbac-role.yaml

#   curl -o iam_policy_v1_to_v2_additional.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.4.0/docs/install/iam_policy_v1_to_v2_additional.json

#   POLICY_ROLE_ARN=$(aws iam create-policy --policy-name AWSLoadBalancerControllerAdditionalIAMPolicy --policy-document file://iam_policy_v1_to_v2_additional.json | jq -r .Policy.Arn)

#   echo "이 부분에서 role name을 얻어서 연동해야 한다."
#   exit 1

#   aws iam attach-role-policy \
#   --role-name your-role name \
#   --policy-arn ${POLICY_ROLE_ARN}
fi

# AWS Load Balancer Controller 설치
helm repo add eks https://aws.github.io/eks-charts

helm repo update


helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=${EKS_CLUSTER_NAME} \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller

kubectl get deployment -n kube-system aws-load-balancer-controller
