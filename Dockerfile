#FROM tomcat:8.0
#COPY ./math/target/*.jar  /usr/local/tomcat/webapps/
#EXPOSE 8080
#CMD ["catalina.sh", "run"]

#run tomcat on centos
FROM centos:centos7
 
######## JDK7
 
#Note that ADD uncompresses this tarball automatically
ADD /Download/jdk-8u144-macosx-x64.dmg /opt
WORKDIR /opt/jdk1.8.0_191
RUN alternatives --install /usr/bin/java java /opt/jdk1.8.0_191/bin/java 1
RUN alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_191/bin/jar 1
RUN alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_191/bin/javac 1
RUN echo "JAVA_HOME=/opt/jdk1.8.0_191" >> /etc/environment
 
######## TOMCAT
 
#Note that ADD uncompresses this tarball automatically
ADD apache-tomcat-7.0.57.tar.gz /usr/share
WORKDIR /usr/share/
RUN mv  apache-tomcat-7.0.57 tomcat7
RUN echo "JAVA_HOME=/opt/jdk1.7.0_72/" >> /etc/default/tomcat7
RUN groupadd tomcat
RUN useradd -s /bin/bash -g tomcat tomcat
RUN chown -Rf tomcat.tomcat /usr/share/tomcat7
EXPOSE 8080
