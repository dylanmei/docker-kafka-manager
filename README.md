kafka-manager
-------------

Docker build for [Kafka-Manager](https://github.com/yahoo/kafka-manager), a tool for managing Apache Kafka. Get it at Docker Hub: [dylanmei/kafka-manager](https://hub.docker.com/r/dylanmei/kafka-manager/)

## example

Run:

```sh
docker run --rm -p 9000:9000 dylanmei/kafka-manager -Dkafka-manager.zkhosts=localhost:2181
```

Supply properties to configure Kafka-manager. For example, to run with basic-auth and increase the default timeouts:

```sh
docker run --rm -p 9000:9000 \
  dylanmei/kafka-manager \
    -Dkafka-manager.zkhosts=localhost:2181 \
    -Dkafka-manager.api-timeout-millis=10000 \
    -Dkafka-manager.cluster-actors-ask-timeout-millis=10000 \
    -Dkafka-manager.partition-offset-cache-timeout-secs=30 \
    -Dkafka-manager.broker-view-thread-pool-size=10 \
    -Dkafka-manager.broker-view-max-queue-size=1000 \
    -Dkafka-manager.broker-view-update-seconds=10 \
    -DbasicAuthentication.enabled=true \
    -DbasicAuthentication.username=foo \
    -DbasicAuthentication.password=bar
```

There are also ENV vars that will be interpolated in `/usr/kafka-manager/conf/application.conf`

| ENV | config |
|-----|--------|
| ZK_HOSTS | kafka-manager.zkhosts |
| CONSUMER_PROPERTIES_FILE | kafka-manager.consumer.properties.file |
| APPLICATION_SECRET | play.crypto.secret |
| KAFKA_MANAGER_AUTH_ENABLED | basicAuthentication.enabled |
| KAFKA_MANAGER_USERNAME | basicAuthentication.username |
| KAFKA_MANAGER_PASSWORD | basicAuthentication.password |
