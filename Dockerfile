FROM maven:3.9.9-eclipse-temurin-25 AS builder
WORKDIR /app

COPY . .
RUN ./mvnw -DskipTests package

FROM eclipse-temurin:25-jre
WORKDIR /app

RUN useradd -r -u 1001 appuser
COPY --from=builder /app/target/*.jar /app/app.jar

EXPOSE 8080

USER appuser
ENTRYPOINT ["java", "-jar", "/app/app.jar"]