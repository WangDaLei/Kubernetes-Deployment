#!/bin/bash

exec chroot --userspec=1000 / /home/elk/elasticsearch/bin/elasticsearch &
export JAVA_HOME=/home/elk/elasticsearch/jdk && cd /root/logstash/bin && ./logstash -f ../config/logstash.conf &
export JAVA_HOME=/home/elk/elasticsearch/jdk && cd /root/kibana/bin && ./kibana --allow-root &

tail -f /dev/null
