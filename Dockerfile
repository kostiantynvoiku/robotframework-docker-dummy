FROM ubuntu:16.04

RUN apt-get update \
      && apt-get install -y software-properties-common \
      && apt-add-repository ppa:qameta/allure \
      && apt-get update \
      && apt-get install --quiet --assume-yes python3-pip unzip firefox wget less xvfb git allure

RUN wget --no-verbose https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg --install google-chrome-stable_current_amd64.deb; apt-get --fix-broken --assume-yes install

COPY ./requirements.txt /tmp
RUN pip3 install -r /tmp/requirements.txt


RUN CHROMEDRIVER_VERSION=`wget --no-verbose --output-document - https://chromedriver.storage.googleapis.com/LATEST_RELEASE` \
    && wget --no-verbose --output-document /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip \
    && unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver \
    && chmod +x /opt/chromedriver/chromedriver \
    && ln -fs /opt/chromedriver/chromedriver /usr/local/bin/chromedriver

RUN GECKODRIVER_VERSION=`wget --no-verbose --output-document - https://api.github.com/repos/mozilla/geckodriver/releases/latest | grep tag_name | cut -d '"' -f 4` \
      && wget --no-verbose --output-document /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/$GECKODRIVER_VERSION/geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz \
      && tar --directory /opt -zxf /tmp/geckodriver.tar.gz \
      && chmod +x /opt/geckodriver \
      && ln -fs /opt/geckodriver /usr/local/bin/geckodriver
      
RUN apt-get autoclean