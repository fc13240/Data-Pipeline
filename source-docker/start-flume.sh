#!/bin/bash
ip=$1
echo $ip

echo "step 1) copying ip at flume_send.conf"

sed -i 's/<Reciever-IP>/'$ip'/g' /home/pipeline-admin/flume_send.conf || { echo "IP coudnt be copied."; exit 1; }

echo "step 2) starting flume agent"
cd $HOME/flume/bin || { echo "flume/bin folder is not present"; exit 1; }
nohup ./flume-ng agent --conf /home/pipeline-admin/flume/conf --conf-file /home/pipeline-admin/flume_send.conf --name sendAgent -Df.root.logger=INFO,console &
