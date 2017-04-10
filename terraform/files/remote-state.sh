#!/bin/bash

terraform remote config \
    -backend=s3 \
    -backend-config="bucket=mue-masternode-terraform-04b062a1-0cad-46a7-ba24-6fdc0484e1f3" \
    -backend-config="key=terraform.tfstate" \
    -backend-config="region=eu-west-1"

terraform remote pull
