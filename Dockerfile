# Use the latest Ubuntu container as the base
FROM ubuntu:20.04

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# This is to make tzdata install without user interaction
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Install necessary dependencies
RUN apt-get update \
    && apt-get install -y \
    curl \
    sudo \
    git \
    jq \
    tar \
    unzip \
    iputils-ping \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Add Ansible PPA and install Ansible
RUN apt-get update \
    && apt-add-repository --yes --update ppa:ansible/ansible \
    && apt-get install -y ansible \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user 'runner'
RUN useradd -m runner \
    && mkdir /actions-runner \
    && chown runner:runner /actions-runner

# Switch to the non-root user 'runner'
USER runner

WORKDIR /actions-runner

# Download the latest runner package as the `runner` user
ADD --chown=runner:runner https://github.com/actions/runner/releases/download/v2.313.0/actions-runner-osx-arm64-2.313.0.tar.gz .

RUN echo "97258c75cf500f701f8549289c85d885a9497f7886c102bf4857eed8764a9143  actions-runner-osx-arm64-2.313.0.tar.gz" | shasum -a 256 -c

# Extract the GitHub Actions runner
RUN tar xzf ./actions-runner-osx-arm64-2.313.0.tar.gz

# Configure the runner & start
COPY --chown=runner:runner entrypoint.sh .
RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
