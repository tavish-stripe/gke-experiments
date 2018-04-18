#!/usr/bin/env bash

kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=$(gcloud config get-value core/account)

kubectl apply -f istio-0.7.1/install/kubernetes/istio-auth.yaml

bash istio-0.7.1/install/kubernetes/webhook-create-signed-cert.sh \
    --service istio-sidecar-injector \
    --namespace istio-system \
    --secret sidecar-injector-certs

kubectl apply -f istio-0.7.1/install/kubernetes/istio-sidecar-injector-configmap-release.yaml

cat istio-0.7.1/install/kubernetes/istio-sidecar-injector.yaml | \
     ./istio-0.7.1/install/kubernetes/webhook-patch-ca-bundle.sh > \
     istio-0.7.1/install/kubernetes/istio-sidecar-injector-with-ca-bundle.yaml

kubectl apply -f istio-0.7.1/install/kubernetes/istio-sidecar-injector-with-ca-bundle.yaml

kubectl -n istio-system get deployment -listio=sidecar-injector

kubectl label namespace default istio-injection=enabled
