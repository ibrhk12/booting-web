# Use Maven image to build the Spring Boot application
FROM maven:3.8.4-openjdk-17-slim as BUILDER

# Pass in the version as a build argument
ARG VERSION=0.0.1-SNAPSHOT

# Set the working directory for the build
WORKDIR /build/

# Copy the Maven project files into the image
COPY src /build/src/
COPY pom.xml /build/


# Copy the built JAR file into the target directory and rename it
COPY target/booting-web-${VERSION}.jar application.jar

# Use OpenJDK image to run the Spring Boot application
FROM openjdk:17-jdk-slim

# Set the working directory for the application
WORKDIR /app/

# Copy the JAR file from the build stage into the application directory
COPY --from=BUILDER /build/application.jar /app/

CMD ["java", "-jar", "/app/application.jar"]