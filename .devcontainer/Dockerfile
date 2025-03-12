# https://mcr.microsoft.com/en-us/artifact/mar/devcontainers/python/tags
FROM mcr.microsoft.com/devcontainers/python:dev-3.12-bookworm

RUN apt-get update && \
    apt-get install -y \
      sudo \
      locales \
      net-tools \
      iputils-ping \
      dnsutils \
      bash-completion \
      less \
      curl \
      wget \
      tar \
      unzip \
      make \
      gcc \
      git \
      vim \
      tmux \
      jq \
      fzf \
      groff \
      procps

# ロケール設定
RUN echo 'ja_JP.UTF-8 UTF-8' >> /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=ja_JP.UTF-8
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

ENV PATH $PATH:/root/.local/bin

# update & install package
RUN apt update && apt install -y sshpass gosu

# ansible install
RUN pip install ansible==11.3.0

# ansible mount dir
RUN mkdir /ansible
WORKDIR /ansible