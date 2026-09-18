# --- 1. S3 BUCKET FOR CLOUDTRAIL LOGS ---
resource "aws_s3_bucket" "audit_logs" {
  bucket        = "enterprise-audit-logs-bucket-${var.environment}"
  force_destroy = true

  tags = {
    Name = "enterprise-audit-logs"
  }
}

# Block public access entirely on audit logs
resource "aws_s3_bucket_public_access_block" "audit_logs_block" {
  bucket                  = aws_s3_bucket.audit_logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# --- 2. REQUIRED S3 BUCKET POLICY FOR CLOUDTRAIL ---
data "aws_caller_identity" "current" {}

resource "aws_s3_bucket_policy" "client_trail_policy" {
  bucket = aws_s3_bucket.audit_logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AWSCloudTrailAclCheck"
        Effect    = "Allow"
        Principal = { Service = "cloudtrail.amazonaws.com" }
        Action    = "s3:GetBucketAcl"
        Resource  = aws_s3_bucket.audit_logs.arn
      },
      {
        Sid       = "AWSCloudTrailWrite"
        Effect    = "Allow"
        Principal = { Service = "cloudtrail.amazonaws.com" }
        Action    = "s3:PutObject"
        Resource  = "${aws_s3_bucket.audit_logs.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}

# --- 3. AWS CLOUDTRAIL FOR AUDITABILITY ---
resource "aws_cloudtrail" "enterprise_trail" {
  name                          = "enterprise-security-audit-trail"
  s3_bucket_name                = aws_s3_bucket.audit_logs.id
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true

  # Ensure the bucket policy is created before CloudTrail attempts to write
  depends_on = [aws_s3_bucket_policy.client_trail_policy]

  tags = {
    Name = "enterprise-security-trail"
  }
}

# --- 4. CLOUDWATCH LOG GROUP ---
resource "aws_cloudwatch_log_group" "security_logs" {
  name              = "/aws/security/enterprise-monitoring"
  retention_in_days = 30

  tags = {
    Name = "security-log-group"
  }
}

# SNS Topic for Security Alerts
resource "aws_sns_topic" "security_alerts" {
  name = "enterprise-security-alerts-topic"
}

# NOTE: GuardDuty resource omitted here to prevent subscription errors 
# in restrictive lab accounts, but can be documented as an enterprise feature.

# resource "aws_guardduty_detector" "primary" {
# enable = true
#
# tags = {
#   Name = "enterprise-guardduty-detector"
# }
#}
