#! /bin/bash
docker build -t runpod .
docker tag runpod manavmahan/runpod-cuda:main
docker push manavmahan/runpod-cuda:main