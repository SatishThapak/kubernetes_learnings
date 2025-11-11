FROM apache/kafka-native:4.1.0

# Optional: Add custom Kafka config (e.g., server.properties)
# COPY server.properties /etc/kafka/docker/server.properties

# Optional: Add init script for topic creation or ACL setup
COPY init-kafka.sh /opt/init-kafka.sh
RUN chmod +x /opt/init-kafka.sh

# Optional: Use an environment variable to control behavior
ENV KAFKA_ROLE=broker

# Default command based on role
CMD ["bash", "-c", "\
  if [ \"$KAFKA_ROLE\" = \"init\" ]; then \
    /opt/init-kafka.sh; \
  else \
    /opt/kafka/bin/kafka-server-start.sh /etc/kafka/docker/server.properties; \
  fi"]
