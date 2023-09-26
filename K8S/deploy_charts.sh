#!/bin/bash

kubectl apply -f namespace.yml
kubectl apply -f petclinic-configmap.yaml
kubectl apply -f role.yaml
kubectl apply -f secret.yaml

kubectl create secret docker-registry aws-ecr-secret \
  --docker-server=${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com \
  --docker-username=AWS \
  --docker-password=$(aws ecr get-login-password) \
  --namespace=spring-petclinic


cd ./helm-charts/mysql-charts/
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm upgrade --install vets-db-mysql bitnami/mysql -n spring-petclinic --values=values.yaml
helm upgrade --install customers-db-mysql bitnami/mysql -n spring-petclinic --values=values.yaml
helm upgrade --install visits-db-mysql bitnami/mysql -n spring-petclinic --values=values.yaml

cd ../api-gateway-chart/
helm upgrade --install api-gateway . --values=values.yaml --set ingress.enabled=$CREATE_INGRESS,service.type=$SERVICE_TYPE

cd ../customers-service-chart/
helm upgrade --install customers-service . --values=values.yaml

cd ../vets-service-chart/
helm upgrade --install vets-service . --values=values.yaml

cd ../visits-service-chart/
helm upgrade --install visits-service . --values=values.yaml