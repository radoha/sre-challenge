FROM gradle:jdk11-slim

# copy code to the container
COPY --chown=gradle:gradle . /home/app

WORKDIR /home/app

# build application 
RUN ./gradlew clean build
