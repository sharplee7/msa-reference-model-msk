FROM gradle:7.4.1-jdk17-alpine as build
WORKDIR /app

COPY gradle/ gradle/
COPY build.gradle settings.gradle gradlew ./
COPY src/ src/

RUN ./gradlew clean build -x test

FROM amazoncorretto:11.0.20-alpine3.18
WORKDIR /app

COPY --from=build /app/build/libs/*-SNAPSHOT.jar ./customer-service.jar 

EXPOSE 8080

ENTRYPOINT ["java","-jar","./customer-service.jar"]
