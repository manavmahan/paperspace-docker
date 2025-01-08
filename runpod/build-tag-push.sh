#! /bin/bash
set -e
docker build --platform linux/amd64 --load -t manavmahan/runpod-cuda:main .
docker push manavmahan/runpod-cuda:main