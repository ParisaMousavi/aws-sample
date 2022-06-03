resource "aws_s3_bucket" "this" {
  bucket = var.name
  tags = merge(
    var.tags,
    {
      created-by = "terraform"
    },
  )
}

resource "aws_s3_bucket_versioning" "this" {
  count  = var.versioning == true ? 1 : 0
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "this" {
  count  = var.acl != null ? 1 : 0
  bucket = aws_s3_bucket.this.id
  acl    = var.acl
}

resource "aws_s3_bucket_policy" "this" {
  count  = var.policy_content != null ? 1 : 0
  bucket = aws_s3_bucket.this.id
  policy = var.policy_content
}
