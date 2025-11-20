#!/usr/bin/env bash
set -euo pipefail


IMAGE_TAG=${1:-latest}
IMAGE_NAME=${CIRCLE_PROJECT_REPONAME:-multi-cloud-app}
ACR_NAME=${ACR_NAME:-myacr$RANDOM}


# Login to ACR
az acr login --name $ACR_NAME


FULL=${ACR_NAME}.azurecr.io/${IMAGE_NAME}:${IMAGE_TAG}


docker tag ${IMAGE_NAME}:${IMAGE_TAG} $FULL


docker push $FULL


echo $FULL
# print for Terraform consumption
cat <<EOF > ../terraform/azure/image_info.txt
image_uri = "$FULL