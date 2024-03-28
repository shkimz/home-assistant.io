ARG VARIANT=2
FROM mcr.microsoft.com/vscode/devcontainers/ruby:${VARIANT}

ARG NODE_VERSION="lts/*"
RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"
RUN su vscode -c "/usr/local/rvm/bin/rvm fix-permissions"

# Install tools
RUN \
  apt update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      ack \
  && echo "ko_KR UTF-8" > /etc/locale.gen \
  && locale-gen ko_KR.UTF-8
