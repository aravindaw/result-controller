# Pull base image.
FROM ubuntu:18.04
 
LABEL maintainer="Aravinda Weerasekara"
 
# Install updates to base image
RUN apt-get update -y \
    && apt-get install -y \
    && apt-get install build-essential curl file git -y

# Install allure
#RUN git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew \
#    && mkdir ~/.linuxbrew/bin \
#    && ln -s ~/.linuxbrew/Homebrew/bin/brew ~/.linuxbrew/bin \
#    && apt-get install locales \
#    && localedef -i en_US -f UTF-8 en_US.UTF-8 \
#    && eval $(~/.linuxbrew/bin/brew shellenv) \
#    && brew --version \
#    && brew install allure \
#    && echo allure --version \
#    && allure serve

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install default-jre-headless \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -o allure-2.6.0.tgz -Ls https://dl.bintray.com/qameta/generic/io/qameta/allure/allure/2.6.0/allure-2.6.0.tgz \
    && tar -zxvf allure-2.6.0.tgz -C /opt/ \
    && ln -s /opt/allure-2.6.0/bin/allure /usr/bin/allure \ 
    && allure --version

RUN apt-get update \
    && apt-get install -y python3-pip python3-dev \
    && cd /usr/local/bin \
    && ln -s /usr/bin/python3 python \
    && pip3 install --upgrade pip \
    && apt-get install python3-distutils \
    && pip install watchdog

ADD result-controller /home/result-controller

#ADD result_controller.service /lib/systemd/system/result_controller.service

ADD test.sh /home/test.sh

#ENTRYPOINT ["/usr/bin/python3", "/home/result-controller/src/ResultController.py &"]
