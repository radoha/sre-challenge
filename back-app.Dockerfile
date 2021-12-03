FROM gradle:jdk11-slim AS GRADLE_BUILD

# copy code to the container
COPY --chown=gradle:gradle . /home/app

WORKDIR /home/app
 
# build application 
RUN ./gradlew clean build --info --stacktrace
 
# the second stage of our build will use open jdk 8 on alpine 3.9
FROM openjdk:11-jre-slim-buster

RUN mkdir -p /home/app

# copy only the artifacts we need from the first stage and discard the rest
COPY --from=GRADLE_BUILD /app/back/build/libs/back-0.1.0.jar /app.jar
 
ENTRYPOINT ["java", "-jar", "/app.jar"]
