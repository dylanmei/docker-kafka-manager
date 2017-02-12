#!/bin/sh

exec ./bin/kafka-manager -Dconfig.file=conf/application.conf  "${@}"
