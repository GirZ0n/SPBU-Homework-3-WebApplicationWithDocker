# I ЭТАП: сборка приложения
FROM alpine as builder
LABEL stage=webApplicationBuilder

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
