#!/bin/bash

Usage=$(cat <<EOF
start:
  Start a Kind cluster and docker registry
stop:
  Delete kind cluster and delete docker registry
EOF)

if [[ $1 == "start" ]];
then
  echo ... Starting
elif [[ $1 == "stop" ]];
then
  echo ... Stop
else
  echo "$Usage"
fi
