# --- FETCH LATEST UBUNTU AMI ---
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

# --- 1. BASTION HOST (Hub VPC - Public Subnet) ---
resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.hub_public.id
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "enterprise-hub-bastion"
  }
}

# --- 2. INTERNAL WEB APP INSTANCE (Spoke VPC - Private Subnet) ---
resource "aws_instance" "web_app" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.spoke_private_app.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  # Basic user data to bootstrap a simple web service for verification
  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>Enterprise Spoke App Online</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "spoke-private-web-server"
  }
}
