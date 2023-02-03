FROM maven:3-openjdk-17 AS build

WORKDIR /opt/app

COPY ./ /opt/app
RUN mvn clean install -DskipTests


#Docker Build Stage
FROM openjdk:17

COPY --from=build /opt/app/target/*.jar app.jar

ENV PORT 8761
EXPOSE $PORT

ENTRYPOINT ["java","-jar","-Xmx1024M","_Dserver.port=${PORT}","app.jar"]