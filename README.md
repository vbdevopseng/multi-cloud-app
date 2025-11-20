# multi-cloud-app_GPT


├── README.md
├── app/
│ ├── app.py
│ ├── requirements.txt
│ ├── Dockerfile
│ └── tests/
│ └── test_app.py
├── .circleci/
│ └── config.yml
├── terraform/
│ ├── aws/
│ │ ├── main.tf
│ │ ├── variables.tf
│ │ └── outputs.tf
│ └── azure/
│ ├── main.tf
│ ├── variables.tf
│ └── outputs.tf
└── scripts/
├── push_to_ecr.sh
└── push_to_acr.sh




What this does

A minimal Flask app runs on port 5000 and returns JSON at /.

CircleCI builds and tests the app, builds a Docker image, and pushes it to the target cloud container registry (AWS ECR or Azure ACR).

Terraform is used to create the registry and a simple container host service:

AWS: creates an ECR repository and an Elastic Beanstalk application + environment (Docker). CircleCI will set the EB application version to the pushed image.

Azure: creates an ACR (Azure Container Registry) and an App Service (Linux) Web App for Containers. CircleCI will update the Web App to use the new image.

Prerequisites

GitHub repository.

CircleCI account and a project connected to GitHub.

AWS account with permissions for ECR, Elastic Beanstalk, IAM, S3 (required by EB), and ECS/AWS resources used by Terraform.

Azure subscription with rights to create Resource Groups, ACR and App Service.

Local machine for running Terraform (or use CircleCI to run Terraform - this config runs Terraform in CircleCI).

Required environment variables (set in CircleCI project settings -> Environment Variables)

For both clouds / general

CIRCLECI_PROJECT_REPONAME (optional but helpful) — your repo name.

For AWS

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

AWS_DEFAULT_REGION (e.g. us-east-1)

EB_S3_BUCKET (an S3 bucket name to be used by Elastic Beanstalk's application versions. You can create it via Terraform or create it manually.)

For Azure

AZURE_CLIENT_ID

AZURE_CLIENT_SECRET

AZURE_TENANT_ID

AZURE_SUBSCRIPTION_ID

For CircleCI Docker image tagging (optional)

IMAGE_TAG (if not set, CircleCI build number will be used)