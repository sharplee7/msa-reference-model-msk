#!/bin/bash

AWS_REPO_ACCOUNT=359192146206
AWS_REGION=ap-northeast-2
PRIVATE_ECR=$AWS_REPO_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $PRIVATE_ECR