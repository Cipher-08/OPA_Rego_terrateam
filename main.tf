provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "infrasity_logs_1" {
  bucket = "infrasity-logs-bucket"

  versioning {
    enabled = true
  }

}
