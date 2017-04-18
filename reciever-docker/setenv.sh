#!/bin/bash

alias notebook="jupyter notebook --ip='*'"

export PATH=/home/pipeline-admin/spark/bin:home/pipeline-admin/spark/sbin:home/pipeline-admin/anaconda2/bin:$PATH
export PATH=/home/pipeline-admin/kafka/bin:/home/pipeline-admin/flume/bin:$PATH

export SPARK_HOME=/home/pipeline-admin/spark

export PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH
export PYTHONPATH=$SPARK_HOME/python/lib/py4j-0.10.1-src.zip:$PYTHONPATH

export JAVA_HOME=/etc/alternatives/java_sdk

export PATH=$HOME/sbt/bin:$PATH
