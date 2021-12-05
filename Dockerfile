FROM gradle:jdk11-slim

# copy code to the container
COPY --chown=gradle:gradle . /home/app

WORKDIR /home/app

RUN ls -la

# build application 
RUN $PWD/gradlew clean build --info --stacktrace
