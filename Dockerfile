FROM centos:centos6

ARG data-source-ip
ARG server-ip

RUN yum -y update;
RUN yum -y clean all;


#Intsall tools which are required
RUN yum install -y  wget dialog curl sudo lsof vim axel telnet nano openssh-server openssh-clients bzip2 passwd tar bc git unzip

#Install Java
RUN yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel

#Create pipeline-admin user.
RUN useradd pipeline-admin -u 1000
RUN echo pipeline-admin | passwd pipeline-admin --stdin

ENV HOME /home/pipeline-admin
WORKDIR $HOME

USER pipeline-admin

#Install Spark
#Spark 2.0.0, precompiled with : mvn -Pyarn -Phadoop-2.6 -Dhadoop.version=2.6.0 -Dyarn.version=2.6.0 -DskipTests -Dscala-2.11 -Phive -Phive-thriftserver clean package
RUN wget http://litpc45.ulb.ac.be/spark-2.0.0_Hadoop-2.6_Scala-2.11.tgz
RUN tar xvzf spark-2.0.0_Hadoop-2.6_Scala-2.11.tgz

ENV SPARK_HOME $HOME/spark

#Install Kafka
RUN wget http://apache.belnet.be/kafka/0.10.0.0/kafka_2.11-0.10.0.0.tgz
RUN tar xvzf kafka_2.11-0.10.0.0.tgz
RUN mv kafka_2.11-0.10.0.0 kafka


ENV PATH $HOME/spark/bin:$HOME/spark/sbin:$HOME/kafka/bin:$PATH

#Install Kafka Python module
RUN pip install kafka-python

#Startup (start SSH, Cassandra, Zookeeper, Kafka producer)
ADD startup_script.sh /usr/bin/startup_script.sh
RUN chmod +x /usr/bin/startup_script.sh

#Environment variables for Spark and Java
ADD setenv.sh /home/pipeline-admin/setenv.sh
RUN chown pipeline-admin:pipeline-admin setenv.sh
RUN echo . ./setenv.sh >> .bashrc

#Install Cassandra
ADD datastax.repo /etc/yum.repos.d/datastax.repo
RUN yum install -y datastax-ddc
RUN echo "/usr/lib/python2.7/site-packages" |tee /home/pipeline-admin/anaconda2/lib/python2.7/site-packages/cqlshlib.pth


#Init Cassandra
ADD init_cassandra.cql /home/pipeline-admin/init_cassandra.cql
RUN chown pipeline-admin:pipeline-admin init_cassandra.cql
