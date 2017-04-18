# flume->kafka->spark->cassandra: data-pipeline

Steps:

 Download data-pipeline repository.

**Starting Receiver:**

1. Go to receiver directory

>  cd reciever-docker

 2. Build Docker image. This might take 15 minutes as it downloads all required packages.

>  docker build  -t stream-pipeline .

![My Image](https://github.com/rashmishrm/data-pipeline/step-images/blob/master/build-reciever.png)

3. Run docker receiver

> docker run -p 4040:4040 -p 8888:8888 -p 23:22 -ti --privileged stream-pipeline

4. Above step drops you in container shell. start all services

> 	sh startup_script.sh
5. check ip of this receiver machine.
>    ifconfig

6.  open Jupyter notebook for receiver program and run step by step. 
    IMP: Do not stop spark streaming. 
 

>  http://localhost:8888/notebooks/notebooks/Spark-stream-and-save.ipynb

**Starting Sender Flume Agent:**

> cd source-docker

1. build docker image

> docker build -t sender .

2. Run docker image

> docker run -p 4545:4545 -ti --privileged sender

3. start flume agent.

> sh start-flume.sh <ip of reciever>



**Check Logs on Jupiter Notebook**

>  http://localhost:8888/notebooks/notebooks/Spark-stream-and-save.ipynb



