output "s3_bucket_name" {
  value = aws_s3_bucket.s3_bucket.bucket
}

output "s3_cypress_name" {
  value = aws_s3_bucket.cypress_result.bucket
}

output "bucket_regional_domain_name_image" {
  value = aws_s3_bucket.cognito_email_images.bucket_regional_domain_name
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.s3_bucket.bucket_regional_domain_name
}