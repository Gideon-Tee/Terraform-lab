# Infrastructure as Code (IaC) and Monitoring Repository

This repository contains two main components:
1. **Terraform** - Infrastructure as Code (IaC) for deploying containerized applications
2. **Prometheus-Grafana** - Monitoring solution for host machines and containers

## 📁 Directory Structure

.
├── Prometheus-Grafana

│   ├── dashboard-images

│   ├── docker-compose.yml

│   ├── prometheus-grafana.png

│   ├── prometheus.yml

│   └── README.md

└── terraform

|    ├── ec2-deployment 

|    └── eks-deployment


---


## 🏗 Terraform Infrastructure

### EC2 Deployment
Contains Terraform configurations to deploy containerized applications on AWS EC2 instances:
- Provisions EC2 instances with Docker runtime
- Sets up networking (VPC, Security Groups)
- Deploys application containers
- Configures load balancing (if applicable)

### EKS Deployment
Contains Terraform configurations to deploy containerized applications on Amazon EKS:
- Creates EKS cluster with worker nodes
- Configures Kubernetes namespaces
- Deploys application Helm charts or manifests
- Sets up IAM roles for service accounts

#### Prerequisites
- Terraform v1.0+
- AWS CLI configured


## Prometheus - Grafana


This repository provides a complete setup for monitoring system and container metrics using **Prometheus** and **Grafana**. The following components are included:
- **Prometheus**: Scrapes metrics from targets such as Node Exporter and cAdvisor.
- **Grafana**: Visualizes the scraped metrics in customizable dashboards.
- **Node Exporter**: Exposes host-level metrics like CPU, memory, disk usage, etc.
- **cAdvisor** (optional): Exposes container-level metrics like resource usage and performance.

---
#### Screenshots of the Grafana Dashboard are included in prometheus-grafana/dashboard-images/


