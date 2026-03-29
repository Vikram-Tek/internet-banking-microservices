FROM eclipse-temurin:21-jre
LABEL maintainer="chinthaka@javatodev.com"
VOLUME /main-app
COPY build/libs/*.jar app.jar
EXPOSE 8084
COPY wait-for-it.sh wait-for-it.sh
RUN chmod +x wait-for-it.sh
# Add bash for wait-for-it.sh
ENTRYPOINT ["java", "-jar", "-Dspring.profiles.active=docker", "/app.jar"]
