FROM node:6

ENV SDK_VERSION=155.0.0
ENV SDK_FILENAME=google-cloud-sdk-${SDK_VERSION}-linux-x86_64.tar.gz
ENV CLOUDSDK_CORE_DISABLE_PROMPTS=1

# need `source` cmd
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN curl -O -J https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/${SDK_FILENAME} && \
    tar -zxvf ${SDK_FILENAME} -C ${HOME} && \
    ${HOME}/google-cloud-sdk/install.sh -q && \
    source ${HOME}/google-cloud-sdk/path.bash.inc && \
    gcloud -v && \
    gcloud components install app-engine-python && \
    rm ${SDK_FILENAME}

RUN echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/chrome.list && \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    apt-get update && \
    apt-get install -y \
        google-chrome-stable \
        imagemagick && \
    apt-get clean && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* && \
    npm install -g bower && \
    npm install -g gulp
