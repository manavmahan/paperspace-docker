# Base image
FROM pytorch/pytorch:2.6.0-cuda12.6-cudnn9-devel

# Update keys and repositories
RUN apt-get update
RUN apt-get install g++ git ssh nginx -y

# Upgrade pip and install PyTorch with CUDA support
RUN pip3 install --no-cache-dir --upgrade pip setuptools wheel
RUN pip3 install --no-cache-dir pytorch-fast-transformers
RUN pip3 install --no-cache-dir --upgrade jupyterlab jupyterlab-git

COPY requirements.txt requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

RUN pip install awscli
COPY sync.sh /sync.sh
RUN chmod +x /sync.sh

RUN apt-get install p7zip-full -y

# Expose port 8888 for JupyterLab
EXPOSE 8888

# Set default shell to bash for Jupyter terminals
ENV SHELL=/bin/bash

COPY start.sh /start.sh
RUN chmod +x /start.sh

# Run JupyterLab
CMD ["/start.sh"]
