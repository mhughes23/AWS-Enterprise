# Connected AWS Enterprise Infrastructure & Threat Operations Center

An enterprise-grade Cloud Infrastructure-as-Code (IaC) and Security Operations project demonstrating the design, deployment, and automated threat monitoring of a multi-VPC AWS environment. Built with Terraform, GitHub Actions, Amazon OpenSearch Serverless, and native AWS security controls.

---

## 📂 Repository Structure
<img width="1710" height="1112" alt="GitHub Repository Structure (phase 1)" src="https://github.com/user-attachments/assets/7d94d2e9-f75a-43a1-8907-12d0ef095c2a" />

*Figure 1: GitHub repository file structure.*

---

## 🔐 State Management & Infrastructure Setup
| Component | Purpose | Screenshot Verification |
| :--- | :--- | :--- |
| **S3 State Backend** | Encrypted remote state storage | ![S3 State Bucket](screenshots/sc-02-s3-state-bucket.png) *(Fig 2)* |
| **DynamoDB Lock Table** | State locking protection | ![DynamoDB Lock Table](screenshots/sc-03-dynamodb-lock.png) *(Fig 3)* |

---

## 🌐 Networking & Connectivity Layer
* **VPC Inventories & Topologies:**
  * ![VPC List View](screenshots/sc-04-vpc-list.png) *(Fig 4: Amazon VPC List View)* 
  * ![VPC Resource Map](screenshots/sc-05-vpc-resource-map.png) *(Fig 5: VPC Resource Map)*
* **Routing & Connectivity:**
  * ![VPC Peering Connection](screenshots/sc-06-vpc-peering.png) *(Fig 6: VPC Peering Connection)* 
  * ![VPC Interface Endpoint](screenshots/sc-07-vpc-endpoint.png) *(Fig 7: VPC Endpoint / PrivateLink)*

---

## 🛡️ Security, IAM & Compute Workloads
* **Execution & IAM:**
  * ![Terminal Execution Output](screenshots/sc-08-terminal-output.png) *(Fig 8: Terminal Execution Output)*
  * ![Least Privilege IAM Role](screenshots/sc-09-iam-role-summary.png) *(Fig 9: Least-Privilege IAM Role Summary)*
* **Micro-Segmentation & Compute:**
  * ![Database SG Ingress Restrictions](screenshots/sc-10-db-sg-restrictions.png) *(Fig 10: Database Security Group Ingress Restrictions)*
  * ![EC2 Instances Dashboard](screenshots/sc-11-ec2-instances.png) *(Fig 11: EC2 Instances Dashboard with running VMs)*

---

## 🤖 CI/CD Automation & Compliance
* **Auditing & Pipelines:**
  * ![CloudTrail Event History](screenshots/sc-12-cloudtrail-history.png) *(Fig 12: AWS CloudTrail Event History Dashboard)*
  * ![GitHub Actions Successful Run](screenshots/sc-13-github-actions-run.png) *(Fig 13: GitHub Actions Successful Pipeline Run)*

---

## 🔍 Threat Detection, SIEM & Incident Response
* **Verification & SIEM:**
  * ![Private Web App Verification](screenshots/sc-14-web-app-verification.png) *(Fig 14: Private Web App Verification output)*
  * ![OpenSearch Collections](screenshots/sc-15-opensearch-collections.png) *(Fig 15: OpenSearch Serverless Collections Dashboard)*
* **Event-Driven Security:**
  * ![EventBridge Target Configuration](screenshots/sc-16-eventbridge-target.png) *(Fig 16: EventBridge Target Configuration)*

---

## 🚀 Quick Start
```bash
git clone [https://github.com/your-username/aws-enterprise-infrastructure.git](https://github.com/your-username/aws-enterprise-infrastructure.git)
cd aws-enterprise-infrastructure/environments/prod
terraform init && terraform apply<img width="1710" height="1112" alt="GitHub Repository Structure (phase 1)" src="https://github.com/user-attachments/assets/d3d3a21f-8386-43c0-afa9-a220299dad27" />
