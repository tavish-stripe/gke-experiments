#!/usr/bin/env bash

kubectl run hello-node --image=us.gcr.io/tavish-200820/hello-node:v1 --port=8080
kubectl expose deployment hello-node --type=LoadBalancer
