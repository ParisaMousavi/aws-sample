resource "aws_s3_bucket" "cognito_email_images" {
  bucket = "${lower(var.projectname)}-${lower(var.environment)}-${lower(var.region)}-cognito-image"
  acl    = "public-read"
  # policy = file("${path.module}/policy.json")

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject"
      ],
      "Principal": "*",
      "Effect": "Allow",
      "Sid": "",
      "Resource": "arn:aws:s3:::${lower(var.projectname)}-${lower(var.environment)}-${lower(var.region)}-cognito-image/*"
    }
  ]
}
POLICY

  versioning {
    enabled = false
  }

  tags = {
    Name        = "${lower(var.projectname)}-${lower(var.environment)}-${lower(var.region)}-cognito-image"
    Environment = var.environment
    Project     = var.projectname
    CostCenter  = var.costcenter
  }
}

resource "aws_s3_bucket_object" "image1" {
  key    = "solution-1.png"
  bucket = aws_s3_bucket.cognito_email_images.id
  source = "../cognito/email-images/solution-1.png"
  acl    = "public-read"
  etag   = filemd5("../cognito/email-images/solution-1.png")
}
