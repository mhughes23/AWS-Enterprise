# --- IAM ROLE FOR EC2 INSTANCES ---
resource "aws_iam_role" "ec2_secure_role" {
  name = "enterprise-ec2-secure-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "ec2-secure-role"
  }
}

# Attach a basic policy for CloudWatch logging and SSM (Systems Manager session management)
resource "aws_iam_role_policy_attachment" "ssm_server_policy" {
  role       = aws_iam_role.ec2_secure_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Create an Instance Profile to pass the role to EC2
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "enterprise-ec2-instance-profile"
  role = aws_iam_role.ec2_secure_role.name
}

# --- SECURITY GROUPS ---

# 1. Bastion / Management SG (Hub VPC)
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Security group for hub bastion host"
  vpc_id      = aws_vpc.hub.id

  ingress {
    description = "Allow SSH from trusted IP or local"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Tighten this to your specific home IP in production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sg"
  }
}

# 2. Web Application SG (Spoke VPC - Private Subnet)
resource "aws_security_group" "web_sg" {
  name        = "web-app-sg"
  description = "Security group for internal web servers"
  vpc_id      = aws_vpc.spoke.id

  # Allow HTTP/HTTPS only from internal peering or a load balancer (No direct public inbound)
  ingress {
    description = "Allow HTTP from Hub VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.hub.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-app-sg"
  }
}

# 3. Database SG (Spoke VPC - Private DB Subnet)
resource "aws_security_group" "db_sg" {
  name        = "database-sg"
  description = "Security group for database tier"
  vpc_id      = aws_vpc.spoke.id

  # Important: Allow inbound DB traffic ONLY from the Web App Security Group
  ingress {
    description     = "Allow PostgreSQL from Web Tier only"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "database-sg"
  }
}
