FROM eclipse-temurin:17-jdk-alpine
WORKDIR /
ADD /target/*.jar configServer.jar
EXPOSE 8000
CMD["java","-jar","configServer.jar"]
