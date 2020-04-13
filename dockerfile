FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/jenkins/src
COPY pom.xml /home/jenkins
RUN mvn -f /home/jenkins/pom.xml clean package
