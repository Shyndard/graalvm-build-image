###################################################
# Run with docker build -t graalvm-native-build . #
###################################################

FROM fedora:33 AS build

# Installing usefull command
RUN yum install wget -y

# Installing GraalVM
WORKDIR /graalvm/
RUN wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-20.3.1/graalvm-ce-java11-linux-amd64-20.3.1.tar.gz
RUN tar -xvzf graalvm-ce-java11-linux-amd64-20.3.1.tar.gz
ENV JAVA_HOME=/graalvm/graalvm-ce-java11-20.3.1
ENV PATH=${JAVA_HOME}/bin:${PATH}

# Installing graalvm native image
RUN yum install gcc glibc-devel zlib-devel -y
RUN gu install native-image

# Installing maven
WORKDIR /maven/
RUN wget http://mirror.ibcp.fr/pub/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -O /maven/maven.tar.gz
RUN tar -zxvf /maven/maven.tar.gz
ENV M2_HOME=/maven/apache-maven-3.6.3
ENV PATH=${M2_HOME}/bin:${PATH}

# Removing useless dependency
RUN yum remove wget -y