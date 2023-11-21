#!/bin/bash

AWS_REPO_ACCOUNT=359192146206
AWS_REGION=ap-northeast-2
PRIVATE_ECR=$AWS_REPO_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com
PRIVATE_ECR_IMG=$PRIVATE_ECR/customer-service:1.0.0
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $PRIVATE_ECR

docker tag customer-service:1.0.0 $PRIVATE_ECR_IMG
docker push $PRIVATE_ECR_IMG
docker rmi $PRIVATE_ECR_IMG customer-service:1.0.0
