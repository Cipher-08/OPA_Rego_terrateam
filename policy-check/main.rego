package main

# Deny any AWS security group ingress rule that allows unrestricted SSH access (port 22 open to 0.0.0.0/0)
deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "aws_security_group"

  # Check each ingress rule in the 'after' state of the security group
  some ingress
  ingress = resource.change.after.ingress[_]
  ingress.from_port == 22
  ingress.to_port == 22
  ingress.protocol == "tcp"

  # Check for unrestricted access in CIDR blocks
  some cidr
  cidr = ingress.cidr_blocks[_]
  cidr == "0.0.0.0/0"

  msg = sprintf("Security Group %v has an ingress rule allowing unrestricted SSH access on port 22.", [resource.address])
}
