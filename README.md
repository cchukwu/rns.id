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

#####################################

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

#####################################


Services Running:
I left the services running on my GCP account incase the team needs to confirm the URL for the LoadBalancer and Conatiner image on Cloud Run:

load_balancer_ip = "34.98.125.202"
service_url = "https://rns-service-ghtmekoyta-uc.a.run.app"



Improvements/Best Practices:

Infrastructure as Code (IaC) Practices
Version Control: Use a version control system (e.g., Git) for Terraform configurations to track changes, review code, and manage releases.
Code Review: Implement code review processes for Terraform changes to ensure quality and compliance with your organization's standards.
Modularization: Utilize Terraform modules to reuse code, simplify management, and maintain consistency across your infrastructure.
State Management: Use remote state backends (e.g., GCS) with state locking and encryption to securely manage Terraform state files. Consider splitting state files for different environments or components to reduce blast radius and improve manageability.

Security and Compliance
Principle of Least Privilege: Assign minimal necessary permissions to the Terraform service account and other GCP resources. Regularly audit IAM roles and permissions.
Secrets Management: Avoid hardcoding sensitive information in Terraform files. Use Google Cloud Secret Manager or environment variables for managing secrets.
Networking Security: Implement VPC Service Controls and Private Google Access to minimize exposure to the public internet. Use Cloud Armor to protect against DDoS attacks.
Encryption: Ensure data at rest and in transit is encrypted. Use customer-managed encryption keys (CMEK) where applicable for greater control.

Reliability and Scalability
High Availability: Design your infrastructure for high availability by deploying resources across multiple zones/regions where applicable (e.g., Cloud SQL read replicas, Cloud Run service region redundancy).
Load Testing: Before going live, conduct load testing to understand how your infrastructure performs under stress and identify potential bottlenecks.
Monitoring and Alerting: Utilize Google Cloud Operations Suite (Monitoring and Logging) to set up comprehensive monitoring and alerting for your infrastructure and applications. Monitor key metrics and set up alerts for anomalous behavior.
Disaster Recovery: Implement disaster recovery strategies, including backup and restore procedures for critical data and configuration. Document and regularly test your recovery process.

Deployment and Maintenance
CI/CD Integration: Integrate Terraform with CI/CD pipelines to automate deployments and apply infrastructure changes through a controlled process.
Change Management: Adopt a structured change management process for applying updates to your infrastructure, including testing in staging environments before production deployments.
Documentation: Keep comprehensive documentation of your infrastructure architecture, deployment processes, and operational procedures.

Scalability Considerations
Auto-scaling: Leverage auto-scaling capabilities of Cloud Run and other managed services to automatically adjust resource allocation in response to traffic patterns.
Load Balancing: Use HTTP(S) Load Balancing to distribute traffic across services and regions, enhancing performance and fault tolerance.