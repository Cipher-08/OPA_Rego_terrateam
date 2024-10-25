package main

# Deny any AWS security group ingress rule that allows unrestricted SSH access
deny[msg] {
  resource := input.resources[_]
  resource.type == "aws_security_group"

  # Check each ingress rule for unrestricted access on port 22
  some ingress
  ingress = resource.values.ingress[_]
  ingress.from_port == 22
  ingress.to_port == 22
  ingress.protocol == "tcp"

  # Iterate over cidr_blocks to detect unrestricted access (0.0.0.0/0)
  some cidr
  cidr = ingress.cidr_blocks[_]
  cidr == "0.0.0.0/0"

  msg = sprintf("Security Group %v has an ingress rule allowing unrestricted SSH access on port 22.", [resource.name])
}
