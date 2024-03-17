FROM adoptopenjdk/openjdk17:alpine-jre

WORKDIR /heliannuuthus

COPY build/libs/app.jar /heliannuuthus/

EXPOSE 13000

ENV JVM_OPTS="-Xmx512m -Xms256m -XX:+UseG1GC"

CMD ["java", "-jar", "app.jar"]

