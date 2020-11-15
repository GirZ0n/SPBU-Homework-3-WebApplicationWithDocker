# I ЭТАП: сборка приложения
FROM alpine as builder

# Добавляем openjdk
RUN apk update && apk upgrade && apk add openjdk8

# Создаём пользователя
ENV APPLICATION_USER ktor

# Добавляем пользователя
RUN adduser -D -g '' $APPLICATION_USER

# Создаём папку /app, в которой будет хранится наше приложение
# Предоставляем разрешения пользователю
RUN mkdir /app
RUN chown -R $APPLICATION_USER /app

# Устанавливаем нашу папку как рабочую директорию
WORKDIR /app

# Marks this container to use the specified $APPLICATION_USER
USER $APPLICATION_USER

# Копируем исходники в нашу папку
COPY . .

# Устанавливаем переменную JAVA_HOME
RUN export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Запускаем сборку
RUN ./gradlew build

# II ЭТАП: запуск приложения
FROM alpine

# Добавляем openjdk
RUN apk update && apk upgrade && apk add openjdk8

# Устанавливаем переменную JAVA_HOME
RUN export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Копируем jar из предыдущего этапа
COPY --from=builder ./app/build/libs/webApplicationWithDocker.jar .

# Запускаем jar
CMD ["java", "-server", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-XX:InitialRAMFraction=2", "-XX:MinRAMFraction=2", "-XX:MaxRAMFraction=2", "-XX:+UseG1GC", "-XX:MaxGCPauseMillis=100", "-XX:+UseStringDeduplication", "-jar", "webApplicationWithDocker.jar"]

## ---------------------------------
#FROM alpine
#
## Добавляем openjdk
#RUN apk update && apk upgrade && apk add openjdk8
#
## Создаём пользователя
#ENV APPLICATION_USER ktor
#
## Добавляем пользователя
#RUN adduser -D -g '' $APPLICATION_USER
#
## Создаём папку /app, в которой будет хранится наше приложение
## Предоставляем разрешения пользователю
#RUN mkdir /app
#RUN chown -R $APPLICATION_USER /app
#
## Устанавливаем нашу папку как рабочую директорию
#WORKDIR /app
#
## Marks this container to use the specified $APPLICATION_USER
#USER $APPLICATION_USER
#
## Копируем исходники в нашу папку
#COPY . .
#
## Устанавливаем переменную JAVA_HOME
#RUN export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
#
## Запускаем сборку
#RUN ./gradlew build
#
## Устанавливаем папку c jar как рабочую директорию
#WORKDIR ./build/libs
#
## Запускаем jar
#CMD ["java", "-server", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-XX:InitialRAMFraction=2", "-XX:MinRAMFraction=2", "-XX:MaxRAMFraction=2", "-XX:+UseG1GC", "-XX:MaxGCPauseMillis=100", "-XX:+UseStringDeduplication", "-jar", "webApplicationWithDocker.jar"]

## ---------------------------------
## We select the base image from. Locally available or from https://hub.docker.com/
#FROM openjdk:8-jre-alpine
#
## We define the user we will use in this instance to prevent using root that even in a container, can be a security risk.
#ENV APPLICATION_USER ktor
#
## Then we add the user, create the /app folder and give permissions to our user.
#RUN adduser -D -g '' $APPLICATION_USER
#RUN mkdir /app
#RUN chown -R $APPLICATION_USER /app
#
## Marks this container to use the specified $APPLICATION_USER
#USER $APPLICATION_USER
#
## We copy the FAT Jar we built into the /app folder and sets that folder as the working directory.
#COPY ./build/libs/webApplicationWithDocker.jar /app/webApplicationWithDocker.jar
#WORKDIR /app
#
## We launch java to execute the jar, with good defauls intended for containers.
# CMD ["java", "-server", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-XX:InitialRAMFraction=2", "-XX:MinRAMFraction=2", "-XX:MaxRAMFraction=2", "-XX:+UseG1GC", "-XX:MaxGCPauseMillis=100", "-XX:+UseStringDeduplication", "-jar", "webApplicationWithDocker.jar"]
