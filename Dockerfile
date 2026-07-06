# ===== STAGE 1: BUILD =====
FROM maven:3.9.6-eclipse-temurin-8 AS build

WORKDIR /app
COPY . .

RUN mvn clean package -DskipTests

# ===== STAGE 2: RUN =====
FROM tomcat:9.0-jdk8

COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080