# Base image
FROM nvidia/cuda@sha256:24c8e3581ea6330038b0d374920721983312627f8adbfcf390bdb4b399d280ed

# Update keys and repositories
RUN apt-get update
RUN apt-get install g++ git ssh nginx -y

RUN apt-get install python3-full python3-pip -y && \
    python3 -m venv /opt/venv && \
    . /opt/venv/bin/activate

RUN . /opt/venv/bin/activate && pip install --no-cache-dir --upgrade pip torch
RUN . /opt/venv/bin/activate && pip install --no-cache-dir --upgrade pip setuptools wheel
RUN . /opt/venv/bin/activate && pip install --no-cache-dir pytorch-fast-transformers
RUN . /opt/venv/bin/activate && pip install --no-cache-dir --upgrade jupyterlab jupyterlab-git

COPY requirements.txt requirements.txt
RUN . /opt/venv/bin/activate && pip install --no-cache-dir -r requirements.txt

RUN apt-get update && apt-get install -y unzip curl && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws

COPY sync.sh /sync.sh
RUN chmod +x /sync.sh

# Expose port 8888 for JupyterLab
EXPOSE 8888

# Set default shell to bash for Jupyter terminals
ENV SHELL=/bin/bash

COPY start.sh /start.sh
RUN chmod +x /start.sh

# Run JupyterLab
CMD ["/start.sh"]
