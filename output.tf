output "LB_DNS_Name" {
  #   value = aws_s3_bucket_website_configuration.demo_website.website_endpoint
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}
