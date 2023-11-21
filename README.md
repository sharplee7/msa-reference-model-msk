# 기본 프로그램 설치
- 운영체제는 ubuntu 22.04 에서  작업

- 기본 프로그램 설치
```
cd script
sh 05_install_default.sh
```
- aws cli 설치
```
sh 04_install_aws.sh
```

- terraform 설치
```
sh 06_tfenv.sh
```

- kubectl 설치
```
sh 07_kubectl.sh
```

- helm 설치
```
sh 08_install_helm.sh
```

- eksctl 설치
```
sh 09_install_eksctl.sh
```

## vpc 설치
```
cd environment

terraform init
terraform plan
terraform apply
```

## eks 설치
```
cd eks-blue

terraform init
terraform plan
terraform apply
```

## eks addon 설치
- 환경변수
```
export EKS_CLUSTER_NAME=eks-blueprint-blue
export EKS_ACCOUNT_ID=359192146206
export EKS_REGION=ap-northeast-2
```
- aws loadbalancer controller 설치
- ebs csi driver 설치
## application 설치

- argocd 설치

```
cd helm_chart
sh 01_repo_add.sh argocd
sh 02_install.sh argocd

# 패스워드 확인
kubectl -n argo-cd-ns get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

- jenkins 설치

```
cd helm_chart
sh 01_repo_add.sh jenkins
sh 02_install.sh jenkins
```

## application code
- application 코드 받기 ( https://github.com/sharplee7/amazon-msk-spring-boot-eda-exmple.git )
- 빌드하기
```
cd order-service/

# 빌드
./gradlew build

# docker container build
sh 02_docker_build.sh

# docker image 확인
docker images

# docker image push
sh 01_docker_push.sh
```
- 배포하기
```
sh 00_ecr_login.sh
helm install order-service ./helm_chart/
```