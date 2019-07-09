
FROM node:10-slim

# https://github.com/wv-gis/mudak-wrm-public/issues/2
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE DontWarn
# https://github.com/phusion/baseimage-docker/issues/58
ENV DEBIAN_FRONTEND noninteractive

# Update dependencies list and install essential dependencies
# https://docs.docker.com/install/linux/docker-ce/ubuntu/
RUN apt-get update -qq \
    && apt-get install -qq \
      apt-transport-https \
      apt-utils \
      ca-certificates \
      gnupg2 \
      software-properties-common \
      > /dev/nul

# https://docs.docker.com/install/linux/docker-ce/ubuntu/
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

# https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md#running-puppeteer-in-docker
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c \
      'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" \
      >> /etc/apt/sources.list.d/google.list'

# Update dependencies list
RUN apt-get update -qq

# Install Docker
# https://docs.docker.com/install/linux/docker-ce/ubuntu/
RUN apt-get install -qq \
      docker-ce \
      docker-ce-cli \
      containerd.io \
      > /dev/nul

# Install Docker Compose
# https://docs.docker.com/compose/install/
RUN curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" \
      -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# Install latest chrome dev package and fonts to support major charsets
# Note: this installs the necessary libs to make the bundled version of Chromium that Puppeteer installs, work.
# https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md#running-puppeteer-in-docker
RUN apt-get install -qq \
      google-chrome-unstable \
      fonts-ipafont-gothic \
      fonts-wqy-zenhei \
      fonts-thai-tlwg \
      fonts-kacst \
      ttf-freefont \
      --no-install-recommends \
      > /dev/nul \
    && rm -rf /var/lib/apt/lists/*

# Install Yarn
RUN npm i -g yarn

WORKDIR /app

# Install puppeteer so it's available in the container.
RUN npm i --loglevel error --no-save puppeteer \
    # Add user so we don't need --no-sandbox.
    # same layer as npm install to keep re-chowned files from using up several hundred MBs more space
    && groupadd -r pptruser && useradd -r -g pptruser -G audio,video pptruser \
    && mkdir -p /home/pptruser/Downloads \
    && chown -R pptruser:pptruser /home/pptruser \
    && chown -R pptruser:pptruser /app/node_modules

CMD ["google-chrome-unstable"]

# Allow pptruser user to manage Docker as a non-root user
# https://docs.docker.com/install/linux/linux-postinstall/
RUN usermod -aG docker pptruser

# Run everything after as non-privileged user.
USER pptruser