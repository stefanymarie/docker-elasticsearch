FROM ubuntu:14.04
MAINTAINER Stephen Paul Suarez <ssuarez@agsx.net>

RUN echo 'deb http://us.archive.ubuntu.com/ubuntu/ trusty universe' >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y wget openjdk-7-jre-headless

RUN apt-get -y install supervisor
RUN mkdir -p /var/log/supervisor

RUN wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.1.tar.gz
RUN tar zxvf elasticsearch-1.1.1.tar.gz
RUN mv elasticsearch-1.1.1 /opt/elasticsearch
RUN mkdir -p /opt/elasticsearch/data
RUN mkdir -p /etc/elasticsearch/
RUN mkdir -p /data/log


ENV ES_HEAP_SIZE 10g
RUN swapoff -a

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD usr/bin/configure /usr/bin/configure
ADD usr/bin/run /usr/bin/run
RUN chmod +x /usr/bin/run /usr/bin/configure

EXPOSE 9200
EXPOSE 9300

RUN apt-get install -y python-pip
RUN pip install pyyaml

VOLUME ["/opt/elasticsearch/data"]

CMD /usr/bin/run