#!/bin/bash

helm uninstall api-gateway customers-service vets-service visits-service

cd ./api-gateway-chart/
helm install api-gateway . --values=values.yaml

cd ../customers-service-chart/
helm install customers-service . --values=values.yaml

cd ../vets-service-chart/
helm install vets-service . --values=values.yaml

cd ../visits-service-chart/
helm install visits-service . --values=values.yaml