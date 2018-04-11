docker build -t hello-node:v1 .
docker tag hello-node:v1 us.gcr.io/tavish-200820/hello-node:v1
gcloud auth configure-docker
docker push us.gcr.io/tavish-200820/hello-node:v1

gcloud container images list-tags us.gcr.io/tavish-200820/hello-node
