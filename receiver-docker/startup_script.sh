#!/bin/bash

service sshd start
service cassandra start

su pipeline-admin $HOME/kafka/bin/zookeeper-server-start.sh $HOME/kafka/config/zookeeper.properties  > /home/pipeline-admin/zookeeper.log 2>&1 &
su pipeline-admin $HOME/kafka/bin/kafka-server-start.sh $HOME/kafka/config/server.properties > /home/pipeline-admin/kafka.log 2>&1 &

sleep 18
cqlsh -f init_cassandra.cql

sleep 5
echo starting notebook
nohup jupyter notebook --ip='*' &

echo starting flume agent
cd $HOME/flume/bin
nohup ./flume-ng agent --conf /home/pipeline-admin/flume/conf --conf-file /home/pipeline-admin/flume_receive.conf --name receiveAgent -Df.root.logger=INFO,console &