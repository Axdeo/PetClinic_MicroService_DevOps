helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install petclinic-mysql bitnami/mysql -n spring-petclinic --values=values.yaml