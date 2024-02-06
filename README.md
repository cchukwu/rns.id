# rns.id
DevOps Trial

##Version Requirements

Terraform v1.2.9
Google provider v5.15.0

Ensure Terraform and the Google provider are at these versions to maintain compatibility with the configurations provided.

##GCP Infrastructure with Terraform

This repository contains Terraform configurations for provisioning a Google Cloud Platform (GCP) environment, including a Virtual Private Cloud (VPC), subnets, firewall rules, a Google Cloud Storage (GCS) bucket for Terraform state management, a Cloud SQL database, and a Cloud Run service with an HTTP Load Balancer.

##Architecture Overview

The infrastructure setup is divided into several key components, managed through reusable Terraform modules and configurations:

rns.id/
│
├── gcp-vpc/
│   ├── backend.tf
│   ├── main.tf
│   ├── outputs.tf
│   ├── variables.tf
│   └── versions.tf
│
├── gcp-database/
│   ├── backend.tf
│   ├── main.tf
│   ├── outputs.tf
│   ├── variables.tf
│   └── versions.tf
│
├── cloud-run/
│   ├── backend.tf
│   ├── main.tf
│   ├── outputs.tf
│   ├── variables.tf
│   └── versions.tf
│
├── remote-backend/
│   ├── main.tf
│   ├── outputs.tf
│   ├── provider.tf
│   └── variables.tf
│
└── modules/
    ├── database/
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    │
    ├── firewall/
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    │
    ├── gcs/
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    │
    ├── subnets/
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    │
    └── vpc/
        ├── main.tf
        ├── outputs.tf
        └── variables.tf


VPC Network: A custom Virtual Private Cloud (VPC) network that includes public and private subnets across a specified region. This provides a segregated environment for resources and services.

Cloud SQL Database: A fully managed relational database service, with configurations to deploy within the custom VPC network for enhanced security and connectivity.

Cloud Run Service: A managed platform for deploying containerized applications, configured for public access with an HTTP Load Balancer for incoming traffic management.

Serverless VPC Access: A connector to allow serverless services, like Cloud Run, to securely access resources within the VPC network.

Firewall Rules: Set up to control inbound and outbound traffic to and from the VPC subnets, ensuring secure access patterns.

GCS Bucket for Terraform State: A dedicated Google Cloud Storage bucket to store Terraform state files, enabling team collaboration and state management.

HTTP Load Balancer: Configured to route external HTTP traffic to the Cloud Run service, facilitating access to the deployed application.


##Directory Structure

gcp-vpc/: Contains Terraform configurations for the VPC, subnets, and firewall rules.

gcp-database/: Terraform configurations for provisioning the Cloud SQL database instance.

cloud-run/: Configurations for deploying the Cloud Run service and setting up the HTTP Load Balancer.

remote-backend/: Sets up a GCS bucket to store Terraform state files.

modules/: Reusable Terraform modules for VPC, subnets, firewall rules, database, and GCS bucket.

##Key Terraform Files

main.tf: The primary configuration file in each directory, defining the resource provisioning logic.
variables.tf: Defines input variables for Terraform configurations, allowing customization.
outputs.tf: Specifies output values that can be used for referencing in other configurations or for informational purposes.
backend.tf: Configuration for Terraform backend to manage state files, specifically set to use GCS in this setup.
versions.tf: Enforces specific versions of Terraform and the Google provider to ensure consistency across environments.


## USAGE

Step 1: Pre-requisites
Install Terraform: Ensure Terraform v1.2.9 is installed. Download Terraform and follow the installation guide for your operating system (I use a macbook)

Configure GCP Access:

Set up a Google Cloud Platform account if you don't already have one.
Create a new project or select an existing project.

Create a service account with necessary roles (e.g., Editor or custom roles with specific permissions) and download the JSON key file.
Set the environment variable GOOGLE_APPLICATION_CREDENTIALS to the path of the JSON key file:

export GOOGLE_APPLICATION_CREDENTIALS="path/to/your-service-account-file.json"

Enable Required APIs:

Use the Google Cloud Console or gcloud CLI to enable the following APIs for your project:
Compute Engine API
Cloud Run API
Cloud SQL Admin API
Service Networking API
Cloud Resource Manager API

Step 2: Initialize Backend for Terraform State

Provision the GCS Bucket
Navigate to the rns.id/remote-backend/ directory.
Modify main.tf as necessary (e.g., set the bucket_name).
Run terraform init followed by terraform apply to create the GCS bucket.

Step 3: Provision the VPC Network and Related Resources
Navigate to the rns.id/gcp-vpc/ directory.
Initialize Terraform:

terraform init
terraform plan
terraform apply
Confirm the action when prompted.

Step 4: Provision the Cloud SQL Database
Ensure the VPC is provisioned as Cloud SQL will use it.
Navigate to the rns.id/gcp-database/ directory.
Run terraform init, terraform plan, and terraform apply as done previously.

Step 5: Deploy the Cloud Run Service and Configure the HTTP Load Balancer
Ensure the VPC and Cloud SQL Database are provisioned.
Navigate to the rns.id/cloud-run/ directory.
Run terraform init, terraform plan, and terraform apply.