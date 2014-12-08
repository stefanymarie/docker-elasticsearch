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

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 9200

VOLUME ["/opt/elasticsearch/data"]

CMD supervisord -n