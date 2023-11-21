#!/bin/bash

aws cloudformation create-stack \
  --region ap-northeast-2 \
  --stack-name eks-vpc-stack \
  --template-url https://s3.us-west-2.amazonaws.com/amazon-eks/cloudformation/2020-10-29/amazon-eks-vpc-private-subnets.yaml
