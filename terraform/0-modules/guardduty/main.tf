resource "aws_guardduty_detector" "this" {
  enable = var.enable

  datasources {
    s3_logs {
      enable = true
    }
    kubernetes {
      audit_logs {
        enable = false
      }
    }
  }
}