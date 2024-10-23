package main

resource_types = {"aws_s3_bucket"}

resources[resource_type] = all {
    some resource_type
    resource_types[resource_type]
    all := [name |
        name := input.resource_changes[_]
        name.type == resource_type
    ]
}

num_creates[resource_type] = num {
    some resource_type
    resource_types[resource_type]
    all := resources[resource_type]
    creates := [res | res := all[_]; res.change.actions[_] == "create"]
    num := count(creates)
}

deny[msg] {
    some i
    num_resources := num_creates["aws_s3_bucket"]
    num_resources > 0
    not input.resource_changes[i].change.after.server_side_encryption_configuration
    msg := "S3 Bucket encryption is not enabled."
}
