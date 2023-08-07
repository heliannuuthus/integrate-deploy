FROM gradle:8-jdk11

RUN --mount=type=cache,id=apt-cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,id=apt-lib,target=/var/lib/apt,sharing=locked \
    sed -i 's/http:\/\/ports.ubuntu.com/http:\/\/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && apt update && apt-get install -y --no-install-recommends curl wget build-essential ca-certificates \
    && apt-get install -y --no-install-recommends python3.9  \
    && apt-get install -y --no-install-recommends nodejs npm \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static \
    && export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup\
    && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && wget -q https://mirrors.aliyun.com/golang/go1.20.linux-$(dpkg --print-architecture).tar.gz -O /tmp/go.tar.gz \
    && tar -C /usr/local -xzf /tmp/go.tar.gz \
    && rm /tmp/go.tar.gz 
    
ENV JAVA_HOME=/opt/java/openjdk \
    GRADLE_HOME=/opt/gradle-8.0 \
    PYTHONPATH=/usr/bin/python3.9 \ 
    GOPATH=/go \
    NODE_HOME=/usr/local \
    PATH=/root/.cargo/bin:/root/.rustup:/usr/local/go/bin:$PATH


RUN ls -l /var/dpkg