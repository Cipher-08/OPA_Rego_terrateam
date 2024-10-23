package terraform.s3

import future.keywords.in

deny[message] {
  some resource in input.resource_changes
  resource.type == "aws_s3_bucket"
  not resource.change.after.server_side_encryption_configuration
  message = sprintf("S3 Bucket %s does not have encryption enabled.", [resource.change.after.bucket])
}

debug[input] {
  some resource in input.resource_changes
}
