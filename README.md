kafka-manager
-------------

Docker build for [Kafka-Manager](https://github.com/yahoo/kafka-manager), a tool for managing Apache Kafka. Get it at Docker Hub: [dylanmei/kafka-manager](https://hub.docker.com/r/dylanmei/kafka-manager/)

## example

Run with basic auth and bump up the default timeouts

```sh
docker run --rm -p 9000:9000 \
  -e "KM_BASICAUTHENTICATION_USERNAME=foo" \
  -e "KM_BASICAUTHENTICATION_PASSWORD=bar" \
  kafka-manager \
    -Dkafka-manager.zkhosts=localhost:2181 \
    -Dkafka-manager.api-timeout-millis=10000 \                                                                                                                                                                               
    -Dkafka-manager.cluster-actors-ask-timeout-millis=10000 \
    -Dkafka-manager.partition-offset-cache-timeout-secs=30 \
    -Dkafka-manager.broker-view-thread-pool-size=10 \
    -Dkafka-manager.broker-view-max-queue-size=1000 \
    -Dkafka-manager.broker-view-update-seconds=10 \
    -DbasicAuthentication.enabled=true
```
