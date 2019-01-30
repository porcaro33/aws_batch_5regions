#!/bin/bash

OUTFILE="./hostcounter.txt"
#echo "REGION^TIME^c5.large^c5.xlarge^c5.2xlarge^c5.4xlarge^c5.9xlarge^c5.18xlarge" > $OUTFILE

for REGION in us-west-2 us-west-1 us-east-1 us-east-2 ca-central-1
do
  TIME=`date +%Y%m%d%H%M`
  C5L=`aws ec2 --region ${REGION} describe-instances --filters "Name=instance-state-name, Values=running" "Name=instance-type, Values=c5.large"| jq -r '.Reservations[].Instances[].InstanceId'| wc -l`
  C5XL=`aws ec2 --region ${REGION} describe-instances --filters "Name=instance-state-name, Values=running" "Name=instance-type, Values=c5.xlarge"| jq -r '.Reservations[].Instances[].InstanceId'| wc -l`
  C52XL=`aws ec2 --region ${REGION} describe-instances --filters "Name=instance-state-name, Values=running" "Name=instance-type, Values=c5.2xlarge"| jq -r '.Reservations[].Instances[].InstanceId'| wc -l`
  C54XL=`aws ec2 --region ${REGION} describe-instances --filters "Name=instance-state-name, Values=running" "Name=instance-type, Values=c5.4xlarge"| jq -r '.Reservations[].Instances[].InstanceId'| wc -l`
  C59XL=`aws ec2 --region ${REGION} describe-instances --filters "Name=instance-state-name, Values=running" "Name=instance-type, Values=c5.9xlarge"| jq -r '.Reservations[].Instances[].InstanceId'| wc -l`
  C518XL=`aws ec2 --region ${REGION} describe-instances --filters "Name=instance-state-name, Values=running" "Name=instance-type, Values=5.18xlarge"| jq -r '.Reservations[].Instances[].InstanceId'| wc -l`
  if [[ ${REGION} == "us-west-2" ]]; then
    echo ${TIME} ^ ${REGION} ^ ${C5L} ^ ${C5XL} ^ ${C52XL} ^ ${C54XL} ^ ${C59XL} ^ ${C518XL} >> $OUTFILE
  else
    echo "_" ^ ${REGION} ^ ${C5L} ^ ${C5XL} ^ ${C52XL} ^ ${C54XL} ^ ${C59XL} ^ ${C518XL} >> $OUTFILE
  fi
done
