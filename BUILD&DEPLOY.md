# Gradle build all apps in Docker
docker build -t sre-challenge-all-apps .

# Build Spring Boot uServices with customized application.yaml
docker build -t popye/sre-challenge-back-app:0.1.0   -f app/back/src/main/docker/Dockerfile app/back/src/main/resources
docker build -t popye/sre-challenge-front-app:0.1.2  -f app/front/src/main/docker/Dockerfile app/front/src/main/resources
docker build -t popye/sre-challenge-reader-app:0.1.0 -f app/reader/src/main/docker/Dockerfile app/reader/src/main/resources

# Push images to Docker Hub
docker login -u popye
docker push popye/sre-challenge-back-app:0.1.0
docker push popye/sre-challenge-front-app:0.1.0
docker push popye/sre-challenge-reader-app:0.1.0

# Create desired namespaces
kubectl apply -f namespaces.yaml

# Deploy Postgres
helm install -n postgres sre-challenge-pg bitnami/postgresql -f postgresql/values-custom.yaml

# Deploy Kafka
helm install -n kafka sre-challenge-kafka bitnami/kafka -f kafka/values-custom.yaml

# Deploy Back App
helm install -n demo-back back-app helm/back-app/

# Deploy Front App
helm install -n demo-front front-app helm/front-app/

# Deploy Reader App
helm install -n demo-reader reader-app helm/reader-app/
