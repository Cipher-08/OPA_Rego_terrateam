provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "infrasity_logs" {
  bucket = "infrasity-logs-bucket"

  versioning {
    enabled = true
  }

}
