FROM eclipse-temurin:21-jre

LABEL maintainer="chinthaka@javatodev.com"

WORKDIR /app

# Copy JAR from Gradle build
COPY build/libs/core-banking-service-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8092

ENTRYPOINT ["java", "-jar", "-Dspring.profiles.active=docker", "app.jar"]
