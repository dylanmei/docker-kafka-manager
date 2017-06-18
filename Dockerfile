FROM openjdk:8-jdk

ARG http_proxy
ARG https_proxy
ARG release_version

RUN apt-get update \
 && apt-get install -y git curl unzip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN git clone --branch "${release_version}" "https://github.com/yahoo/kafka-manager" /usr/src/kafka-manager \
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
