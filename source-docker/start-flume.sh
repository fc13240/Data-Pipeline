#!/bin/bash
ip=$1
echo $ip
sed -i 's/<Reciever-IP>/'$ip'/g' /home/pipeline-admin/flume_send.conf

echo starting flume agent
cd $HOME/flume/bin
nohup ./flume-ng agent --conf /home/pipeline-admin/flume/conf --conf-file /home/pipeline-admin/flume_send.conf --name sendAgent -Df.root.logger=INFO,console &
