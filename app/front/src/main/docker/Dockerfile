ARG BASE_IMAGE_REGISTRY=docker.io
ARG BASE_IMAGE_NAME=openjdk
ARG BASE_IMAGE_TAG=11-slim

FROM ${BASE_IMAGE_REGISTRY}/${BASE_IMAGE_NAME}:${BASE_IMAGE_TAG}

ARG JAR_VERSION=0.1.0
ARG APP_NAME=front
ARG JAR_FILE=${APP_NAME}-${JAR_VERSION}.jar

COPY --from=sre-challenge-all-apps:latest /home/app/app/${APP_NAME}/build/libs/${JAR_FILE} /app.jar
COPY application.yaml /application.yaml

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app.jar","--spring.config.additional-location=/"]
