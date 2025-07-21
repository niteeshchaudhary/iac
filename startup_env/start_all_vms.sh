#!/bin/bash
# Starts all EC2 instances with Name tag starting with 'myvm-' in eu-north-1

REGION="eu-north-1"
INSTANCE_IDS=$(aws ec2 describe-instances \
  --region $REGION \
  --filters "Name=tag:Name,Values=myvm-*" "Name=instance-state-name,Values=stopped" \
  --query "Reservations[].Instances[].InstanceId" \
  --output text)

if [ -z "$INSTANCE_IDS" ]; then
  echo "No stopped instances found with Name tag 'myvm-*' in $REGION."
else
  echo "Starting instances: $INSTANCE_IDS"
  aws ec2 start-instances --region $REGION --instance-ids $INSTANCE_IDS
fi 