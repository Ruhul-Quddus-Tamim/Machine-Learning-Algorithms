# Overview
This is a demonstration of how to implement the terraform(IaC) on top of any ETL/ELT pipelines utilizing Airflow. This is an example of terraform how I usually use in my data engineering pipeline projects' for clients.

# Steps for installation
To run Terraform, you need to have it installed on your local machine or a CI/CD server. Terraform needs AWS credentials to authenticate and authorize the actions it performs against AWS resources. There are several ways to provide these credentials to Terraform:

### Step 1: Install Terraform
Download and install Terraform from the **Terraform website**.

### Step 2: Configure AWS Credentials
Set AWS credentials as environment variables on the machine where you will run Terraform.

```
export AWS_ACCESS_KEY_ID=your-access-key-id
export AWS_SECRET_ACCESS_KEY=your-secret-access-key
export AWS_DEFAULT_REGION=your-default-region
```

### Step 3: Running Terraform

On Your Local Machine or if you use any server instances(EC2, Computue Engine):

> 1. Navigate to the directory containing your Terraform configuration files:
```
cd path-to-your-terraform-files
```

> 2. Initialize Terraform:
```
terraform init
```

> 3. Plan the deployment:
```
terraform plan
```

> 4. Apply the deployment:
```
terraform apply
```

# CI/CD Pipeline
You can integrate Terraform with your CI/CD pipeline (e.g., using Jenkins, GitLab CI, GitHub Actions, etc.). In this case, I would typically configure the pipeline to set up the environment variables or use AWS credentials securely stored in the GitHub secret manager.

Example using GitHub Actions:

**.github/workflows/test_deploy.yaml**

```
name: Terraform Deploy

on:
  push:
    branches:
      - main

jobs:
  terraform:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Setup Terraform
      uses: hashicorp/setup-terraform@v1
      with:
        terraform_version: 1.0.0

    - name: Configure AWS credentials
      uses: aws-actions/configure-aws-credentials@v1
      with:
        aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws-region: us-west-2

    - name: Initialize Terraform
      run: terraform init

    - name: Plan Terraform
      run: terraform plan

    - name: Apply Terraform
      run: terraform apply -auto-approve

    - name: Destroy Terraform (optional)
      if: always()
      run: terraform destroy -auto-approve
```

