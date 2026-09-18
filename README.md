# Connected AWS Enterprise Infrastructure Environment

An Infrastructure-as-Code (IaC) project that demonstrates the design and deployment of a connected, multi-VPC AWS environment using Terraform. The project implements a hub-and-spoke network architecture with AWS Transit Gateway, isolated subnet routing, security controls, a highly available application tier, and a private multi-AZ PostgreSQL database.

The environment also includes a GitHub Actions CI/CD workflow that automates Terraform validation, planning, and deployment, providing a repeatable process for managing cloud infrastructure.

## Architecture

The environment consists of:

- **AWS Transit Gateway** — Centralized connectivity between multiple VPCs
- **Hub-and-Spoke VPC Architecture** — Connects VPCs while maintaining network isolation
- **Public Application Load Balancer** — Handles incoming application traffic
- **Private EC2 Instances** — Hosts application workloads without direct public access
- **Amazon RDS PostgreSQL** — Isolated database layer deployed across multiple Availability Zones
- **Route Tables** — Controls traffic flow between public, private, and connected VPC networks
- **Security Groups** — Restricts network access between application components
- **Terraform** — Provisions and manages the AWS infrastructure as code
- **GitHub Actions** — Automates Terraform validation, planning, and deployment

## Key Objectives

- Design a scalable multi-VPC AWS network
- Implement centralized VPC connectivity using Transit Gateway
- Separate public, application, and database network tiers
- Apply least-privilege network access through routing and security groups
- Deploy infrastructure using Infrastructure as Code
- Automate Terraform workflows through GitHub Actions
- Create a repeatable cloud deployment process

## Technologies

`AWS` `Terraform` `Transit Gateway` `VPC` `EC2` `RDS PostgreSQL` `Application Load Balancer` `GitHub Actions` `IAM` `Route Tables` `Security Groups`
