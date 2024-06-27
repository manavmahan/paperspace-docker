# Use the official NVIDIA CUDA image with Ubuntu 22.04 as the base image
FROM nvidia/cuda:12.5.0-devel-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y

# Install dependencies
RUN apt-get install -y \
    git vim wget gcc  make pkg-config apt-transport-https \
    build-essential apt-utils ca-certificates wget git vim mlocate \
    libssl-dev curl openssh-client unzip unrar zip awscli csvkit emacs joe jq  dialog man-db manpages manpages-dev manpages-posix manpages-posix-dev nano iputils-ping sudo ffmpeg libsm6         libxext6 libboost-all-dev gnupg cifs-utils zlib1g software-properties-common \
    && rm -rf /var/lib/apt/lists/*

RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt-get update -y
RUN apt-get install -y --no-install-recommends python3 python3-dev python3-venv python3-distutils-extra
RUN apt-get install -y --no-install-recommends python3-pip
    
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash && apt-get install -y --no-install-recommends git-lfs

# Upgrade pip
RUN pip3 install --upgrade pip

# Install the latest version of PyTorch with CUDA support
RUN pip3 install torch
RUN pip3 install torch-geometric

# Install Jupyter Notebook
RUN pip3 install notebook

RUN git clone --depth https://github.com/Kitware/CMake $HOME/cmake 
WORKDIR $HOME/cmake 
RUN ./bootstrap
RUN make -j"$(nproc)" install

# Set the working directory
WORKDIR /workspace

# Expose the Jupyter Notebook port
EXPOSE 6006 8888

# Set the command to run Jupyter Notebook
CMD ["/bin/sh" "-c" "jupyter lab --allow-root --ip=0.0.0.0 --no-browser --ServerApp.trust_xheaders=True --ServerApp.disable_check_xsrf=False --ServerApp.allow_remote_access=True --ServerApp.allow_origin='*' --ServerApp.allow_credentials=True"]
