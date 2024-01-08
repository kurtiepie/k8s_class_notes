#!/bin/bash

# create registry container unless it already exists
reg_name='kind-registry'
reg_port='5001'

Usage=$(cat <<EOF
start:
  Start a Kind cluster and docker registry
stop:
    Delete kind cluster and delete docker registry
EOF)

# Start Function
function start {
  if [ "$(docker inspect -f '{{.State.Running}}' "${reg_name}" 2>/dev/null || true)" != 'true' ]; then
    docker run \
      -d --restart=always -p "127.0.0.1:${reg_port}:5000" --name "${reg_name}" \
      registry:2
  fi
  # https://github.com/kubernetes/enhancements/tree/master/keps/sig-cluster-lifecycle/generic/1755-communicating-a-local-registry
  cat <<EOF | kubectl apply -f -
  apiVersion: v1
  kind: ConfigMap
  metadata:
    name: local-registry-hosting
    namespace: kube-public
  data:
    localRegistryHosting.v1: |
      host: "localhost:${reg_port}"
      help: "https://kind.sigs.k8s.io/docs/user/local-registry/"
  EOF

  # Install nginx ingress and wait for ingress pod to be activated
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
  
}

function stop {
   echo ...Stopping
}

## Main
if [[ $1 == "start" ]];
then
  start()
elif [[ $1 == "stop" ]];
then
  stop()
else
  echo "$Usage"
fi
