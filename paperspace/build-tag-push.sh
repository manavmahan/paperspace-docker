#! /bin/bash
docker build -t my-gradient-notebook .
docker tag my-gradient-notebook manavmahan/pytorch-cuda-notebook:main
docker push manavmahan/pytorch-cuda-notebook:main