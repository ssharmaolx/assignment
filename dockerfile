#### Assignment 1 


####As metioned in assignment taking centos6 docker base image
FROM centos:centos6    

#Install neccessary development tools
RUN yum install -y gcc 

#Install WGET 
RUN yum install -y wget

#Install tar 
RUN yum install -y tar
########## INSTALL Python2.7
RUN cd /tmp && \
	wget https://www.python.org/ftp/python/2.7.8/Python-2.7.8.tgz && \
	tar xvfz Python-2.7.8.tgz && \
	cd Python-2.7.8 && \
	./configure --prefix=/usr/local && \
	make && \
	make altinstall

########## INSTALL mongo
RUN echo -e "[mongodb]\nname=MongoDB Repository\nbaseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/\ngpgcheck=0\nenabled=1" > /etc/yum.repos.d/mongodb.repo
RUN yum -y update && \
    yum -y install mongo-10gen mongo-10gen-server 
###init scripts were missing ,i was getting error while starting mongod service (/etc/init.d/mongod: line 11: /etc/rc.d/init.d/functions: No such file or directory)
RUN yum -y install initscripts 
RUN chown -R mongod:mongod /var/lib/mongo

######### INSTALL tomcat7

# Download JDK 
RUN cd /opt;wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u55-b13/jdk-7u55-linux-x64.tar.gz; pwd 
RUN cd /opt;tar xvf jdk-7u55-linux-x64.tar.gz
RUN alternatives --install /usr/bin/java java /opt/jdk1.7.0_55/bin/java 1

# Download Apache Tomcat 7 
RUN cd /tmp;wget http://apache.mirrors.pair.com/tomcat/tomcat-7/v7.0.75/bin/apache-tomcat-7.0.75.tar.gz 

# untar and move to proper location 
RUN cd /tmp;tar xvf apache-tomcat-7.0.75.tar.gz
RUN cd /tmp;mv apache-tomcat-7.0.75 /opt/tomcat7
RUN chmod -R 755 /opt/tomcat7
ENV JAVA_HOME /opt/jdk1.7.0_55 
EXPOSE 8080 
CMD /opt/tomcat7/bin/catalina.sh run
