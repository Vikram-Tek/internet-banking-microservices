FROM eclipse-temurin:21-jre

LABEL maintainer="chinthaka@javatodev.com"

WORKDIR /app

COPY build/libs/*.jar app.jar
COPY wait-for-it.sh wait-for-it.sh

RUN chmod +x wait-for-it.sh

EXPOSE 8084

ENTRYPOINT ["java", "-jar", "-Dspring.profiles.active=docker", "app.jar"]
