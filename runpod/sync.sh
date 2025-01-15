#!/bin/bash

login_aws(){
    echo "Logging in to AWS..."
    aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
    aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
    aws configure set default.region $AWS_DEFAULT_REGION
}


copy_to_s3() {
    login_aws
    aws s3 rm $AWS_S3_BUCKET --recursive
    aws s3 cp /workspace/ $AWS_S3_BUCKET --recursive
}

copy_to_workspace() {
    login_aws
    rm -rf /workspace/*
    aws s3 cp $AWS_S3_BUCKET /workspace/ --recursive
}

if [ "$1" == "upload" ]; then
    copy_to_s3
elif [ "$1" == "download" ]; then
    copy_to_workspace
else
    echo "Usage: $0 {upload|download}"
    exit 1
fi