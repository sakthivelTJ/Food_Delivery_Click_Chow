# ==========================================
# Stage 1: Build application with Maven
# ==========================================
FROM maven:3.9-amazoncorretto-21 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests


# ==========================================
# Stage 2: Run on Tomcat 10.1 + Java 21
# ==========================================
FROM tomcat:10.1-jdk21-temurin

# Remove default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Deploy Click Chow as ROOT application
COPY --from=build /app/target/ROOT.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
