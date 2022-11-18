#!/bin/bash

set -x

SCRIPTDIR=$(cd $(dirname "$0") && pwd)

KIND_NODE_TAG=v1.25.2

# Boot cluster
kind create cluster --config "$SCRIPTDIR/kind-cluster.yml" --image kindest/node:${KIND_NODE_TAG} --wait 10m || exit 1

echo "Kubernetes cluster is deployed and reachable"
kubectl cluster-info --context kind-funless-cluster
kubectl apply -f namespace.yml
kubectl apply -f svc-account.yml
kubectl apply -f prometheus-cm.yml
kubectl apply -f prometheus.yml
kubectl apply -f core.yml
kubectl apply -f worker.yml