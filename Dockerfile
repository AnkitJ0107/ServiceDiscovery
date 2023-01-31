FROM openjdk:17
EXPOSE 8761
ADD target/e_server-0.0.1-SNAPSHOT.jar eureka-server.jar
ENTRYPOINT ["java" ,"-jar", "eureka-server.jar"]