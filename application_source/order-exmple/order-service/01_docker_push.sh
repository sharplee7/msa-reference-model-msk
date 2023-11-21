#!/bin/bash

PROJECT_NAME=order-service
TAG_NAME=1.0.0
AWS_REPO_ACCOUNT=359192146206
AWS_REGION=ap-northeast-2
PRIVATE_ECR=$AWS_REPO_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com
PRIVATE_ECR_IMG=$PRIVATE_ECR/${PROJECT_NAME}:${TAG_NAME}
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $PRIVATE_ECR

docker tag ${PROJECT_NAME}:${TAG_NAME} $PRIVATE_ECR_IMG
docker push $PRIVATE_ECR_IMG
docker rmi $PRIVATE_ECR_IMG ${PROJECT_NAME}:${TAG_NAME}
