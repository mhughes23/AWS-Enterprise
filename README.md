# 🛡️ Enterprise-Grade Secure AWS Cloud Foundation & Threat Operations Center

![Terraform](https://img.shields.io/badge/Terraform-1.5.0-purple?style=flat-square&logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Enterprise-orange?style=flat-square&logo=amazon-aws)
![GitHub Actions](https://img.shields.io/badge/CI%2FCF-Automated-blue?style=flat-square&logo=github-actions)
![Security](https://img.shields.io/badge/Security-LeastPrivilege%20%7C%20SIEM-red?style=flat-square)

## 📌 Executive Summary & Problem Statement
Modern enterprises require secure, auditable, and automated cloud foundations that enforce strict network isolation, least-privilege identity controls, and continuous compliance monitoring. 

This project delivers an end-to-end production-grade AWS cloud infrastructure built using **Terraform (Infrastructure as Code)**. Beyond standard deployment, it establishes an automated **Security Operations & Incident Response (SOC/IR) pipeline** leveraging AWS GuardDuty, Security Hub, EventBridge, Amazon SNS, and OpenSearch Serverless for real-time threat detection and log analytics.

---

## 🏛️ System Architecture
The environment utilizes a **Hub-and-Spoke VPC pattern** with dedicated administrative access, isolated application tiers, private data layers, and native serverless security telemetry routing.

> ![Screenshot 13: Architecture Diagram](docs/screenshots/architecture-diagram.png)
*(High-level architecture showing Hub-and-Spoke network segregation, S3/SSM Gateway endpoints, and the security telemetry loop.)*

---

## 🚀 Key Engineering Components

### 1. Network Architecture & Isolation (Hub-and-Spoke)
* **Transit & Management (Hub VPC):** Hosts the administrative Bastion/Management host in a public subnet with strict ingress limits.
* **Workload & Data (Spoke VPC):** Houses the private application tier (subnets without public IPs) and a private database tier protected from direct internet access.
* **VPC Endpoints:** Configured AWS Gateway (S3) and Interface endpoints (SSM/EC2 Messages) to ensure traffic to internal AWS services never traverses the public internet.

### 2. Identity and Access Management (IAM) & Security Groups
* **Least-Privilege Roles:** Compute workloads utilize dedicated IAM instance profiles restricted strictly to minimal operational policies (e.g., `AmazonSSMManagedInstanceCore`) rather than generic administrative privileges.
* **Rigorous Network Boundaries:** Security groups implement default-deny postures; databases accept traffic strictly from internal web application security groups.

> | Security Validation | Description |
| :--- | :--- |
| ![Screenshot 1: IAM Role Summary](docs/screenshots/iam-role-summary.png) | *Least-privilege EC2 instance role displaying zero broad administrator permissions.* |
| ![Screenshot 2: Database SG Rules](docs/screenshots/db-security-group.png) | *PostgreSQL (Port 5432) inbound rules restricted exclusively to the Web Tier SG.* |

---

### 3. Compute & Application Tier
* Dynamically fetches the latest secure Ubuntu LTS AMI via Terraform data sources.
* Deploys a management bastion in the Hub VPC and a resilient web application instance in the private Spoke app subnet.

> | Compute Verification | Description |
| :--- | :--- |
| ![Screenshot 3: EC2 Dashboard](docs/screenshots/ec2-instances.png) | *Running instances split cleanly across Hub public and Spoke private subnets.* |
| ![Screenshot 4: App Verification](docs/screenshots/app-running.png) | *Local verification confirming the internal Apache application service is online.* |

---

### 4. Security, Compliance, & Monitoring
* **AWS CloudTrail:** Multi-region API auditing with log-file validation enabled, feeding an isolated S3 audit bucket.
* **Amazon GuardDuty & Security Hub:** Automated threat detection and centralized posture management active across the account.

> | Security Monitoring | Description |
| :--- | :--- |
| ![Screenshot 5: CloudTrail History](docs/screenshots/cloudtrail-events.png) | *Continuous API auditing and event tracking history.* |
| ![Screenshot 6: GuardDuty Detector](docs/screenshots/guardduty-active.png) | *Active threat detection monitoring core cloud components.* |
| ![Screenshot 7: Security Hub Dashboard](docs/screenshots/security-hub.png) | *Centralized security compliance and posture findings overview.* |

---

## 🔍 Threat Detection & Automated Incident Response (SIEM)

To elevate this project from a standard infrastructure build into a fully functional security operations pipeline, threat telemetry is automatically processed and routed.

* **Amazon OpenSearch Serverless (SIEM):** Timeseries collection backend acting as a serverless log analytics engine.
* **EventBridge Security Rule:** Intercepts high and critical-severity findings from GuardDuty and Security Hub, preventing false-positive noise fatigue.
* **Automated Notification Fan-Out:** Pushes critical incidents instantly to an enterprise **Amazon SNS Topic** for SOC awareness.

> | Detection & SIEM Ops | Description |
| :--- | :--- |
| ![Screenshot 8: OpenSearch Collection](docs/screenshots/opensearch-collection.png) | *Active OpenSearch Serverless TIMESERIES collection for security telemetry.* |
| ![Screenshot 9: EventBridge Rule](docs/screenshots/eventbridge-rule.png) | *Custom JSON event pattern filtering strictly for HIGH and CRITICAL severities.* |
| ![Screenshot 10: EventBridge SNS Target](docs/screenshots/eventbridge-sns-target.png) | *Routing intercepted security events into the enterprise SNS alert topic.* |

---

## ⚙️ CI/CD Pipeline & Automation

Infrastructure changes are managed entirely through code automation using GitHub Actions. Pull requests undergo automatic formatting checks, validation, and execution plans.

> | Automation Workflows | Description |
| :--- | :--- |
| ![Screenshot 11: GitHub Actions Success](docs/screenshots/github-actions-success.png) | *Successful workflow run executing init, validate, plan, and apply steps.* |
| ![Screenshot 12: PR Plan Comment](docs/screenshots/github-pr-plan.png) | *Automated Terraform plan output posted directly to pull request reviews.* |
| ![Screenshot 15: State Locking S3/DynamoDB](docs/screenshots/terraform-state.png) | *Remote state configuration ensuring team collaboration safety via locking.* |
| ![Screenshot 16: Terraform Plan Output](docs/screenshots/terraform-plan-terminal.png) | *Clean terminal output verifying zero drift across the live infrastructure.* |

---

## 📂 Repository Structure
```text
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions CI/CD pipeline definition
├── environments/
│   └── prod/
│       ├── backend.tf          # S3 State Locking configuration
│       ├── compute.tf          # EC2 Bastion & Web App instances
│       ├── monitoring.tf       # CloudTrail, GuardDuty, OpenSearch SIEM
│       ├── networking.tf       # Hub-and-Spoke VPCs, Peering, Endpoints
│       ├── security.tf         # IAM roles & Least-Privilege Security Groups
│       └── variables.tf        # Environment inputs
└── README.md
