FROM gradle:8-jdk11

RUN --mount=type=cache,id=apt-cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,id=apt-lib,target=/var/lib/apt,sharing=locked \
    apt-get update && apt-get install -y --no-install-recommends curl wget build-essential ca-certificates

RUN --mount=type=cache,id=apt-cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,id=apt-lib,target=/var/lib/apt,sharing=locked \
    apt-get update && apt-get install -y --no-install-recommends python3.9

RUN wget -O go.tar.gz https://mirrors.aliyun.com/golang/go1.20.linux-$(dpkg --print-architecture).tar.gz && \
    tar -C /usr/local -xzf go.tar.gz && \
    rm go.tar.gz

RUN export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static && \
    export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain 1.69.0 && \
    echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc && \
    . $HOME/.cargo/env && rustup default 1.69.0
    

RUN --mount=type=cache,id=apt-cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,id=apt-lib,target=/var/lib/apt,sharing=locked \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get update && apt-get install -y --no-install-recommends nodejs

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Add your application files and build steps here
# For example:
# COPY . /app
# RUN gradle build

# Define the entry point for the container
CMD ["bash"]