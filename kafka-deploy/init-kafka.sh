#!/bin/bash
echo "Waiting for Kafka to be ready..."
sleep 10

/opt/kafka/bin/kafka-topics.sh --bootstrap-server kafka:9092 \
  --create --if-not-exists --topic demo-topic \
  --partitions 1 --replication-factor 1

echo "Topic 'demo-topic' created."
