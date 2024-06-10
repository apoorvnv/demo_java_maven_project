# Use an official Maven image to build the project
FROM maven:3.8.4-openjdk-11 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the project files to the working directory
COPY pom.xml .
COPY src ./src

# Build the project
RUN mvn clean package

# Use an official OpenJDK runtime image
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the application port (adjust as necessary)
EXPOSE 8080

# Set the entry point for the container
ENTRYPOINT ["java", "-jar", "app.jar"]
