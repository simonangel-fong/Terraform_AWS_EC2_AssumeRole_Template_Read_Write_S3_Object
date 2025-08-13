#!/bin/bash

BUCKET_NAME="terraform-iam-template-ec2-read-write-s3"
OBJECT_FILE="test.log"

# update index
sudo apt update

# install unzip
sudo apt install unzip

# install awscli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# create a local file
cat > /home/ubuntu/$OBJECT_FILE <<EOF
$(date) test log message 1st
$(date) test log message 2nd
EOF

# write to s3 bucket
aws s3 cp /home/ubuntu/$OBJECT_FILE s3://$BUCKET_NAME