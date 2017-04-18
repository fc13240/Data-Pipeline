#!/bin/bash
echo "step 1) starting ssh"
service sshd start || { echo "ssh failed"; exit 1; }


echo "step 2) starting cassandra"
service cassandra start|| { echo "cassandra start failed"; exit 1; }

echo "step 3) starting zookeeper"
su pipeline-admin $HOME/kafka/bin/zookeeper-server-start.sh $HOME/kafka/config/zookeeper.properties  > /home/pipeline-admin/zookeeper.log 2>&1 &

echo "step 4) starting kafka server"
su pipeline-admin $HOME/kafka/bin/kafka-server-start.sh $HOME/kafka/config/server.properties > /home/pipeline-admin/kafka.log 2>&1 &


echo "step 5) Waiting before cassandra table creation"
sleep 18
echo Creating cassandra tables
cqlsh -f init_cassandra.cql|| { echo "Cassandra data creation failed"; exit 1; }


sleep 5
echo "step 6) starting notebook"
nohup jupyter notebook --ip='*' &

echo "step 7) starting flume Receiver agent"
cd $HOME/flume/bin
nohup ./flume-ng agent --conf /home/pipeline-admin/flume/conf --conf-file /home/pipeline-admin/flume_receive.conf --name receiveAgent -Df.root.logger=INFO,console &
