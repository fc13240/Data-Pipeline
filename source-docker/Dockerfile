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


#Install Flume

RUN wget http://archive.apache.org/dist/flume/stable/apache-flume-1.7.0-bin.tar.gz
RUN tar -xvf apache-flume-1.7.0-bin.tar.gz
RUN mv apache-flume-1.7.0-bin flume

ENV PATH $HOME/flume/bin:$PATH



USER root

#Environment variables for Spark and Java
ADD setenv.sh /home/pipeline-admin/setenv.sh
RUN chown pipeline-admin:pipeline-admin setenv.sh
RUN echo . ./setenv.sh >> .bashrc

ADD start-flume.sh /usr/bin/start-flume.sh
RUN chmod +x /usr/bin/start-flume.sh


ADD flume_send.conf /home/pipeline-admin/flume_send.conf
RUN chown pipeline-admin:pipeline-admin flume_send.conf


EXPOSE 4545
