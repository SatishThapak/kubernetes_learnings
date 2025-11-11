FROM openjdk:17-jdk-slim

ENV KAFKA_VERSION=3.6.0 \
    SCALA_VERSION=2.13 \
    KAFKA_HOME=/opt/kafka

RUN apt-get update && apt-get install -y curl bash \
    && curl -fSL https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
    | tar -xz -C /opt \
    && mv /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} $KAFKA_HOME \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV PATH=$PATH:$KAFKA_HOME/bin

WORKDIR $KAFKA_HOME

EXPOSE 9092

CMD ["bash", "-c", "export KAFKA_BROKER_ID=$(echo ${HOSTNAME##*-}) && exec $KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties"]
