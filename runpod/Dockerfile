# Base image
FROM pytorch/pytorch:2.6.0-cuda12.4-cudnn9-devel

# Update keys and repositories
RUN apt-get update
RUN apt-get install g++ git ssh nginx -y

# Upgrade pip and install PyTorch with CUDA support
RUN pip3 install --no-cache-dir --upgrade pip setuptools wheel
RUN pip3 install --no-cache-dir pytorch-fast-transformers
RUN pip3 install --no-cache-dir --upgrade jupyterlab jupyterlab-git

# RUN python -c "import blinker; print(blinker.__file__)"
# RUN rm -rf /usr/lib/python3/dist-packages/blinker
# RUN pip install Flask blinker==1.4
# RUN pip3 install -U blinker
# RUN pip3 show blinker
# RUN pip3 install flask flask-cors
COPY requirements.txt requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

RUN apt-get update && apt-get install -y unzip curl && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws

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
