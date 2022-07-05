resource "aws_s3_bucket" "demo_bucket" {
  bucket = "assignment-ctl-demo-bucket"
  acl    = "private"

  #   policy = file("policy.json")

  website {
    index_document = "index.html"
    # error_document = "error.html"
    /*
    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF*/
  }
}

resource "aws_s3_bucket_object" "object" {
  bucket   = aws_s3_bucket.demo_bucket.bucket
  for_each = fileset("D:\\Study\\Assignment\\static_website_winter", "*")
  key      = each.value
  source   = "D:\\Study\\Assignment\\static_website_winter\\${each.value}"

  #   # The filemd5() function is available in Terraform 0.11.12 and later
  #   # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  #   # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("D:\\Study\\Assignment\\static_website_winter\\${each.value}")
}

resource "aws_s3_bucket_public_access_block" "block_policy" {
  bucket = aws_s3_bucket.demo_bucket.id

  block_public_acls   = true
  block_public_policy = true
}