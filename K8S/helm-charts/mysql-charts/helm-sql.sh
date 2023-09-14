helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install vets-db-mysql bitnami/mysql -n spring-petclinic --values=values.yaml
helm install customers-db-mysql bitnami/mysql -n spring-petclinic --values=values.yaml
helm install visits-db-mysql bitnami/mysql -n spring-petclinic --values=values.yaml