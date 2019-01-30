#!/bin/bash

QUEUE="openfoam-batch-jobqueue"
JOBDEF="kobayashi-test"
ARRAYSIZE=10
TIMES=10

for REGION in us-west-2 us-west-1 us-east-1 us-east-2 ca-central-1
do
  echo $REGION
  for i in `seq 1 $TIMES`
  do
    JOBNAME="JOB_$i"
    aws --region $REGION batch submit-job --job-name $JOBNAME"_"$REGION --job-queue $QUEUE --job-definition $JOBDEF
    #aws --region $REGION batch submit-job --job-name $JOBNAME --job-queue $QUEUE --job-definition $JOBDEF --array-properties size=$ARRAYSIZE
    echo "submitted $JOBNAME_$REGION"
    sleep 1
  done
done
