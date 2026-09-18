terraform {
  backend "s3" {
    bucket         = "mhughes-enterprise-tf-state-bucket"
    key            = "foundations/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "tf-state-locks"
    encrypt        = true
  }
}
