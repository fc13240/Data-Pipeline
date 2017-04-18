# flume->kafka->spark->cassandra: data-pipeline
This project creates data pipeline which gets data from flume sender on different host and processes using Kafka-> spark and stores in cassandra.

**Assumptions:**
```
Requires Docker
```


**Steps:**

 Download data-pipeline repository.

**Starting Receiver:**

1. Go to receiver directory
```
cd receiver-docker
```

 2. Build Docker image. This might take some time (~approx 15-20 minutes) as it downloads all required packages.
```
 docker build  -t stream-pipeline .
```

![My Image](https://github.com/rashmishrm/data-pipeline/blob/master/step-images/build-reciever.png)

3. Run docker receiver

```
docker run -p 4040:4040 -p 8888:8888 -p 23:22 -ti --privileged stream-pipeline
```

4. Above step drops you in container shell. start all services

```
sh startup_script.sh
```

![My Image](https://github.com/rashmishrm/data-pipeline/blob/master/step-images/run-receiver.png)

5. check ip of this receiver machine.
```
ifconfig
```

6.  open Jupyter notebook for receiver program and run step by step. 
    IMP: Do not stop spark streaming. 
 

```
http://localhost:8888/notebooks/notebooks/Spark-stream-and-save.ipynb
```

![My Image](https://github.com/rashmishrm/data-pipeline/blob/master/step-images/notebook-1.png)


![My Image](https://github.com/rashmishrm/data-pipeline/blob/master/step-images/notebook-output.png)


**Starting Sender Flume Agent:**

```
cd source-docker
```

1. build docker image

```
docker build -t sender .
```

![My Image](https://github.com/rashmishrm/data-pipeline/blob/master/step-images/build-sender.png)


2. Run docker image

```
docker run -p 4545:4545 -ti --privileged sender
```

3. start flume agent.

```
sh start-flume.sh <ip of reciever>
```

![My Image](https://github.com/rashmishrm/data-pipeline/blob/master/step-images/start-flume-sender.png)

**Check Logs on Jupiter Notebook**

```
http://localhost:8888/notebooks/notebooks/Spark-stream-and-save.ipynb
```


![My Image](https://github.com/rashmishrm/data-pipeline/blob/master/step-images/notebook-output1.png)
