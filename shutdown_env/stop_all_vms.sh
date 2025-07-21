#!/bin/bash
# Stops all EC2 instances with Name tag starting with 'myvm-' in eu-north-1

REGION="eu-north-1"
INSTANCE_IDS=$(aws ec2 describe-instances \
  --region $REGION \
  --filters "Name=tag:Name,Values=myvm-*" "Name=instance-state-name,Values=running" \
  --query "Reservations[].Instances[].InstanceId" \
  --output text)

if [ -z "$INSTANCE_IDS" ]; then
  echo "No running instances found with Name tag 'myvm-*' in $REGION."
else
  echo "Stopping instances: $INSTANCE_IDS"
  aws ec2 stop-instances --region $REGION --instance-ids $INSTANCE_IDS
fi 