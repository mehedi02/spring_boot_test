# # For Java 8, try this
# # FROM openjdk:8-jdk-alpine

# # For Java 11, try this
# FROM adoptopenjdk/openjdk11:alpine-jre

# # Refer to Maven build -> finalName
# ARG JAR_FILE=target/spring-boot-web.jar

# # cd /opt/app
# WORKDIR /opt/app

# # cp target/spring-boot-web.jar /opt/app/app.jar
# COPY ${JAR_FILE} app.jar

# # java -jar /opt/app/app.jar
# ENTRYPOINT ["java","-jar","app.jar"]

# AS <NAME> to name this stage as maven
FROM maven:3.6.3 AS maven
LABEL MAINTAINER="mehedi1670@gmail.com"

WORKDIR /usr/src/app
COPY . /usr/src/app
# Compile and package the application to an executable JAR
RUN mvn package 

# For Java 11, 
FROM adoptopenjdk/openjdk11:alpine-jre

ARG JAR_FILE=docker-spring-boot.jar

WORKDIR /opt/app

# Copy the spring-boot-api-tutorial.jar from the maven stage to the /opt/app directory of the current stage.
COPY --from=maven /usr/src/app/target/${JAR_FILE} /opt/app/

ENTRYPOINT ["java","-jar","docker-spring-boot.jar"]
