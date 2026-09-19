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
| **S3 State Backend** | Encrypted remote state storage | <img width="1710" height="1112" alt="AWS S3 State Bucket" src="https://github.com/user-attachments/assets/62a17980-8299-4565-8915-811050a619b5" />
 *(Fig 2)* |
| **DynamoDB Lock Table** | State locking protection | <img width="1710" height="1112" alt="AWS DynamoDB State Locking Table" src="https://github.com/user-attachments/assets/e67e000b-5c5b-4767-bf7e-317c9461a758" />
 *(Fig 3)* |

---

## 🌐 Networking & Connectivity Layer
* **VPC Inventories & Topologies:**
<img width="1710" height="1112" alt="Amazon VPC List View(Phase 2)" src="https://github.com/user-attachments/assets/f59f8514-b678-4047-86ed-792d20c05818" />
 *(Fig 4: Amazon VPC List View)* 

   <img width="1710" height="1112" alt="VPC Resource Map" src="https://github.com/user-attachments/assets/eb8c5ad4-5d0d-463c-b773-27ca2b987118" />
 *(Fig 5: VPC Resource Map)*

* **Routing & Connectivity:**
  <img width="1710" height="1112" alt="VPC Peering Connection" src="https://github.com/user-attachments/assets/999d1baa-e2e8-461c-8b67-dd4bf47224e8" />
 *(Fig 6: VPC Peering Connection)* 

  <img width="1710" height="1112" alt="VPC Endpoints" src="https://github.com/user-attachments/assets/d18676ab-b699-453f-ad75-8aacfe319c48" />
 *(Fig 7: VPC Endpoint / PrivateLink)*

---

## 🛡️ Security, IAM & Compute Workloads
* **Execution & IAM:**
  <img width="1710" height="1112" alt="Terminal Execution Output" src="https://github.com/user-attachments/assets/3da1beb0-b0fc-41b1-b3ef-1f1cba814780" />
 *(Fig 8: Terminal Execution Output)*

  <img width="1710" height="1112" alt="The Least-Privilege IAM Role Summary(Part 3)" src="https://github.com/user-attachments/assets/a0b3c42c-95b7-47b8-9ddd-3e5e0a4fd6da" />
 *(Fig 9: Least-Privilege IAM Role Summary)*

* **Micro-Segmentation & Compute:**
  <img width="1710" height="1112" alt="Database Security Group Ingress Restrictions" src="https://github.com/user-attachments/assets/c21156ac-a660-4adf-a6b1-ffe9ee8d4aea" />
 *(Fig 10: Database Security Group Ingress Restrictions)*

  <img width="1710" height="1112" alt="The EC2 Instances Dashboard showing both operational virtual machines running (Part 4)" src="https://github.com/user-attachments/assets/c2cde37a-2909-41be-930c-62f1d5c8c464" />
 *(Fig 11: EC2 Instances Dashboard with running VMs)*

---

## 🤖 CI/CD Automation & Compliance
* **Auditing & Pipelines:**
  <img width="1710" height="1112" alt="AWS CloudTrail Event History Dashboard(Part 5)" src="https://github.com/user-attachments/assets/8e5e4fe7-a58d-4d78-bf64-0f4174ccca86" />
 *(Fig 12: AWS CloudTrail Event History Dashboard)*
  
  <img width="1710" height="1112" alt="Github Actions successful run(Part 6)" src="https://github.com/user-attachments/assets/38f2cf0a-f21c-43ef-991c-7ad42c86278a" />
 *(Fig 13: GitHub Actions Successful Pipeline Run)*

---

## 🔍 Threat Detection, SIEM & Incident Response
* **Verification & SIEM:**
  <img width="1710" height="1112" alt="Private Web App Verification Page(Part 4)" src="https://github.com/user-attachments/assets/1257d615-ceeb-4eef-b4d2-9a5f05ca388a" />
  
 *(Fig 14: Private Web App Verification output)*
  <img width="1710" height="1112" alt="OpenSearch Collections" src="https://github.com/user-attachments/assets/da30c8d3-7aad-4fc4-8490-39203c0838ef" />
 *(Fig 15: OpenSearch Serverless Collections Dashboard)*
  
* **Event-Driven Security:**
  <img width="1710" height="1112" alt="The EventBridge Target Configuration (SNS Topic)" src="https://github.com/user-attachments/assets/5dd13d39-b357-4527-ae3e-106e3adc61d2" />
 *(Fig 16: EventBridge Target Configuration)*

---

## 🚀 Quick Start
```bash
git clone [https://github.com/your-username/aws-enterprise-infrastructure.git](https://github.com/your-username/aws-enterprise-infrastructure.git)
cd aws-enterprise-infrastructure/environments/prod
terraform init && terraform apply<img width="1710" height="1112" alt="GitHub Repository Structure (phase 1)" src="https://github.com/user-attachments/assets/d3d3a21f-8386-43c0-afa9-a220299dad27" />
