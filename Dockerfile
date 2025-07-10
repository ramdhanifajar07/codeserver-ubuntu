# Gunakan Ubuntu sebagai base image
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PASSWORD=""

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    gnupg \
    ca-certificates \
    apt-transport-https \
    software-properties-common \
    git \
    nodejs \
    npm \
    sudo \
    libsecret-1-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Tambahkan user 'coder'
RUN useradd -m coder && \
    echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER coder
WORKDIR /home/coder

# Install code-server dari GitHub Releases
RUN curl -fsSL https://code-server.dev/install.sh | sh

EXPOSE 8080

# Jalankan code-server tanpa autentikasi
CMD ["code-server", "--auth=none", "--bind-addr=0.0.0.0:8080", "--disable-telemetry"]
