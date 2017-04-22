FROM debian:jessie

ARG http_proxy
ARG https_proxy

RUN apt-get update \
 && apt-get install -y git curl unzip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# JAVA
ARG JAVA_MAJOR_VERSION=8
ARG JAVA_UPDATE_VERSION=112
ARG JAVA_BUILD_NUMBER=15
ENV JAVA_HOME /usr/jdk1.${JAVA_MAJOR_VERSION}.0_${JAVA_UPDATE_VERSION}

ENV PATH $PATH:$JAVA_HOME/bin
RUN curl -sL --retry 3 --insecure \
  --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
  "http://download.oracle.com/otn-pub/java/jdk/${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-b${JAVA_BUILD_NUMBER}/server-jre-${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-linux-x64.tar.gz" \
  | gunzip \
  | tar x -C /usr/ \
  && ln -s $JAVA_HOME /usr/java \
  && rm -rf $JAVA_HOME/man

RUN git clone https://github.com/yahoo/kafka-manager /usr/src/kafka-manager \
 && cd /usr/src/kafka-manager \
 && echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> build.sbt \
 && ./sbt clean dist \
 && unzip -d /usr/ ./target/universal/kafka-manager-*.zip \
 && ln -s "/usr/$(ls /usr/ | grep kafka-manager)" /usr/kafka-manager \
 && rm -rf /usr/src/kafka-manager /root/.sbt /root/.ivy2

WORKDIR /usr/kafka-manager
ADD docker-entrypoint.sh /
ADD application.conf conf/application.conf

EXPOSE 9000
ENTRYPOINT ["/docker-entrypoint.sh"]
