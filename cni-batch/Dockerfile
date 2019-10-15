FROM azul/zulu-openjdk:11

RUN mkdir /app

COPY build/libs/cni-batch.jar /app/servico.jar

WORKDIR /app

CMD ["java","-Xms1G","-Xmx3G","-Djava.security.egd=file:/dev/./urandom","-jar","/app/servico.jar"]