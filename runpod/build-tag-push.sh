#! /bin/bash
set -e
docker build --platform linux/amd64 --push -t manavmahan/runpod-cuda:main .