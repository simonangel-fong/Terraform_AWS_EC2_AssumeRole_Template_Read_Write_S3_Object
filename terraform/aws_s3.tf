# ##############################
# S3
# ##############################
resource "aws_s3_bucket" "csv_bucket" {
  bucket        = "terraform-iam-template-ec2-read-write-s3"
  force_destroy = true

  tags = {
    Name = "terraform-iam-template-ec2-read-write-s3"
  }
}

# ##############################
# Output
# ##############################
output "s3" {
  value = aws_s3_bucket.csv_bucket.id
}
