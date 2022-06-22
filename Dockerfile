FROM maven:3-openjdk-11 AS build
RUN mkdir -p /home/app/src
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

FROM tomcat:8.0-alpine AS deploy
COPY --from=build /home/app/target/*.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]

