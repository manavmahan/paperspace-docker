FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install Python, pip, and bash
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip

# Set Python3 as the default python
RUN ln -s /usr/bin/python3 /usr/bin/python

# Set the timezone
ENV TZ=Europe/Berlin

# Install tzdata and other packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends tzdata curl vim && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN apt-get update && apt-get install -y \
    bash git-all unzip software-properties-common\
    libgl1-mesa-glx libglib2.0-0 \
    build-essential libopenmpi-dev \
    && rm -rf /var/lib/apt/lists/*

# Install nginx
RUN apt-get update && apt-get install -y openssh-server linux-generic

# COPY nginx.conf /etc/nginx/nginx.conf

# Install pip, JupyterLab, and attrs
RUN pip install --upgrade pip
RUN pip install --upgrade awscli attrs jupyterlab jupyterlab-git

# Install CUDA
RUN pip install --upgrade flake8 matplotlib pytest shapely tqdm
RUN pip install --upgrade opencv-python torch==2.3.1 torch_geometric torchtyping wandb x-transformers

# Expose port 8888 for JupyterLab
EXPOSE 8888

# Set default shell to bash for Jupyter terminals
ENV SHELL=/bin/bash

COPY start.sh /start.sh
RUN chmod +x /start.sh

# Run JupyterLab
CMD ["/start.sh"]

