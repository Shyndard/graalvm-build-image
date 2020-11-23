FROM oracle/graalvm-ce:20.2.0-java11 AS build

# Installing maven
WORKDIR /maven/
RUN yum install wget -y
RUN wget http://mirror.ibcp.fr/pub/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -O /maven/maven.tar.gz
RUN tar -zxvf /maven/maven.tar.gz
ENV M2_HOME=/maven/apache-maven-3.6.3
ENV PATH=${M2_HOME}/bin:${PATH}
RUN yum remove wget -y

# Installing graalvm native image
RUN gu install native-image