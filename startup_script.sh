#!/bin/bash

service sshd start
service cassandra start

su pipeline-admin $HOME/kafka/bin/zookeeper-server-start.sh $HOME/kafka/config/zookeeper.properties  > /home/pipeline-admin/zookeeper.log 2>&1 &
su pipeline-admin $HOME/kafka/bin/kafka-server-start.sh $HOME/kafka/config/server.properties > /home/pipeline-admin/kafka.log 2>&1 &

sleep 15
cqlsh -f init_cassandra.cql
