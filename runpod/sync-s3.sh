#!/bin/bash

sync_s3() {
    # Remove all files in /mnt/s3
    rm -rf /mnt/s3/*

    # Copy all files from /workspace to /mnt/s3
    cp -r /workspace/* /mnt/s3/
}

sync_workspace() {
    # Remove all files in /workspace
    rm -rf /workspace/*

    # Copy all files from /mnt/s3 to /workspace
    cp -r /mnt/s3/* /workspace/
}

if [ "$1" == "sync_s3" ]; then
    sync_s3
elif [ "$1" == "sync_workspace" ]; then
    sync_workspace
else
    echo "Usage: $0 {sync_s3|sync_workspace}"
    exit 1
fi