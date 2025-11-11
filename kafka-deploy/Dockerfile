FROM openjdk:17-jdk-slim

ENV KAFKA_VERSION=3.6.0 \
    SCALA_VERSION=2.13 \
    KAFKA_HOME=/opt/kafka \
    KAFKA_ROLE=broker

# Install Kafka
RUN apt-get update && apt-get install -y curl bash \
    && curl -fSL https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
    | tar -xz -C /opt \
    && mv /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} $KAFKA_HOME \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV PATH=$PATH:$KAFKA_HOME/bin
WORKDIR $KAFKA_HOME

# Optional: Add init script for topic creation
COPY init-kafka.sh /opt/init-kafka.sh
RUN chmod +x /opt/init-kafka.sh

EXPOSE 9092 2181

CMD ["bash", "-c", "\
  if [ \"$KAFKA_ROLE\" = \"broker\" ]; then \
    export KAFKA_BROKER_ID=$(echo ${HOSTNAME##*-}) && \
    exec $KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties; \
  elif [ \"$KAFKA_ROLE\" = \"zookeeper\" ]; then \
    exec $KAFKA_HOME/bin/zookeeper-server-start.sh $KAFKA_HOME/config/zookeeper.properties; \
  elif [ \"$KAFKA_ROLE\" = \"init\" ]; then \
    exec /opt/init-kafka.sh; \
  else \
    echo \"Unknown role: $KAFKA_ROLE\" && exit 1; \
  fi"]
