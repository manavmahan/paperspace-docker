# Use the NVIDIA CUDA base image with CUDA 12.5.1 and cuDNN on Ubuntu 22.04
FROM nvidia/cuda:12.2.2-cudnn8-runtime-ubuntu22.04

# Install Python, pip, and bash
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip

# Set Python3 as the default python
RUN ln -s /usr/bin/python3 /usr/bin/python

RUN apt-get update && apt-get install -y \
    bash git unzip \
    libgl1-mesa-glx libglib2.0-0 \
    build-essential libopenmpi-dev \
    && rm -rf /var/lib/apt/lists/*

# Install pip, JupyterLab, and attrs
RUN pip install --upgrade pip
RUN pip install --upgrade awscli attrs jupyterlab jupyterlab-git
RUN pip install --upgrade opencv-python flake8 matplotlib pytest shapely tqdm
RUN pip install --upgrade opencv-python opencv-python torch torch_geometric torchtyping wandb x-transformers

# Expose port 8888 for JupyterLab
EXPOSE 8888

# Set default shell to bash for Jupyter terminals
ENV SHELL=/bin/bash

# Run JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
