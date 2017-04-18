# data-pipeline

Steps:

1. Download data-pipeline repository.
2. Build Docker image.
	

> docker build  -t stream-pipeline .

3. Run docker. 

>   docker run -p 4040:4040 -p 8888:8888 -p 23:22 -p 56565:56565 -ti --privileged my-pipeline

4.  Start kafka,flume with below script.

> 	sh startup_script.sh

5. Run Telnet to send messages to flume source

> 	curl telnet://localhost:56565

5.  open Jupyter notebook for receiver program and run step by step.
  

> http://localhost:8888/notebooks/notebooks/Spark-stream-and-save.ipynb


