FROM alpine

# Добавляем gradle (вместе с ним добавится openjdk8)
RUN apk update && apk upgrade && apk add openjdk8

#
ENV APPLICATION_USER ktor

# Создаём папку в которой будет хранится наше приложение и назначаем её нашей рабочей директорией
RUN adduser -D -g '' $APPLICATION_USER
RUN mkdir /app
RUN chown -R $APPLICATION_USER /app
WORKDIR /app

#
USER $APPLICATION_USER

# Копируем исходники в нашу папку
COPY . .

# Устанавливаем переменную JAVA_HOME
RUN export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

RUN ./gradlew build

WORKDIR ./build/libs/webApplicationWithDocker.jar

CMD ["java", "-server", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-XX:InitialRAMFraction=2", "-XX:MinRAMFraction=2", "-XX:MaxRAMFraction=2", "-XX:+UseG1GC", "-XX:MaxGCPauseMillis=100", "-XX:+UseStringDeduplication", "-jar", "webApplicationWithDocker.jar"]

# We select the base image from. Locally available or from https://hub.docker.com/
# FROM openjdk:8-jre-alpine

# We define the user we will use in this instance to prevent using root that even in a container, can be a security risk.
# ENV APPLICATION_USER ktor

# Then we add the user, create the /app folder and give permissions to our user.
# RUN adduser -D -g '' $APPLICATION_USER
# RUN mkdir /app
# RUN chown -R $APPLICATION_USER /app

# Marks this container to use the specified $APPLICATION_USER
# USER $APPLICATION_USER

# We copy the FAT Jar we built into the /app folder and sets that folder as the working directory.
# COPY ./build/libs/webApplicationWithDocker.jar /app/webApplicationWithDocker.jar
# WORKDIR /app

# We launch java to execute the jar, with good defauls intended for containers.
# CMD ["java", "-server", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-XX:InitialRAMFraction=2", "-XX:MinRAMFraction=2", "-XX:MaxRAMFraction=2", "-XX:+UseG1GC", "-XX:MaxGCPauseMillis=100", "-XX:+UseStringDeduplication", "-jar", "webApplicationWithDocker.jar"]
