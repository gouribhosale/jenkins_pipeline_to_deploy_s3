# Define an AWS EC2 instance
resource "aws_instance" "jenkinsec2" {
  ami                    = "ami-062a49a8152e4c031"
  instance_type          = "t2.micro"
  key_name               = "prismikaec2"
  subnet_id              = aws_subnet.public-jenkins-subnet.id
  security_groups        = [aws_security_group.jenkins-sg.id]
  associate_public_ip_address = true
  user_data              = file("jenkins.sh")  # Include user data script for Jenkins configuration

  tags = {
    Name = "jenkinsec2"
  }
}

# Define an AWS S3 bucket for hosting the static website
resource "aws_s3_bucket" "my-static-web-bucket" {
  bucket = "jenkinstf-ec2-static-bucket"  # Replace with your desired bucket name
}

# Configure static website hosting for the S3 bucket
resource "aws_s3_bucket_website_configuration" "my-static-web-bucket" {
  bucket = aws_s3_bucket.my-static-web-bucket.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

# Apply ownership controls for the S3 bucket
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.my-static-web-bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Configure public access block settings for the S3 bucket
resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.my-static-web-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}