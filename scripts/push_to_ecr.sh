#!/usr/bin/env bash
set -euo pipefail

IMAGE_TAG=${1:-latest}
IMAGE_NAME=${CIRCLE_PROJECT_REPONAME:-multi-cloud-app}
AWS_REGION=${AWS_DEFAULT_REGION:-us-east-1}
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REPO_NAME=${IMAGE_NAME}-repo

# create repo if missing
aws ecr describe-repositories --repository-names $REPO_NAME >/dev/null 2>&1 || aws ecr create-repository --repository-name $REPO_NAME

# login
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

FULL=${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPO_NAME}:${IMAGE_TAG}

docker tag ${IMAGE_NAME}:${IMAGE_TAG} $FULL

docker push $FULL

echo $FULL
# print for Terraform consumption
cat <<EOF > ../terraform/aws/image_info.txt
image_uri = "$FULL"
EOF