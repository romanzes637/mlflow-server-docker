# Dockerized MLflow Tracking Server

The server uses two stores:
1. `Backend store` for MLflow entities: runs, parameters, metrics, tags, notes, metadata, etc
2. `Artifact store` for other ones: files, models, images, in-memory objects, or model summary, etc

The server can be deployed in one of several scenarios

See MLflow [docs](https://mlflow.org/docs/latest/tracking.html) for actual information

***

## Scenario 5 (with proxied access to artifact store)

### How to run:
1. Go to scenario directory
```sh
cd docker/scenario_5
```
2. Copy and modify "dotenv" files from examples
```sh
cp .env.example .env
cp .env.secret.example .env.secret
```
3. Generate password for username of nginx proxy (e.g. for username "user")
```sh
htpasswd -c .htpasswd user
```
4. Run MLflow
```sh
docker compose up -d
```
> If you need to make changes to docker-compose.yaml, it's convenient to copy docker-compose.yaml to docker-compose.override.yaml and make changes to it

5. Check MLflow UI at 
```
http://YOUR_HOST:5000
```
6. To connect from code, set environment variables
```sh
MLFLOW_TRACKING_URI=http://YOUR_HOST:5000
MLFLOW_TRACKING_USERNAME=HTPASSWD_USERNAME
MLFLOW_TRACKING_PASSWORD=HTPASSWD_PASSWORD
```
* Check MinIO UI
```
http://YOUR_HOST:9001
```
> If you do not need MinIO UI, change ports "9001:9001" to expose "9001" at nginx_minio service
* Check PostgreSQL via pgAdmin at
```
http://YOUR_HOST:5050
```
> If you do not need pgAdmin, comment pgadmin service in docker-compose.yaml

## How to test
1. Install requirements.txt
```sh
pip install -r requirements.txt
```
2. Go to test directory
```sh
cd tests/scenario_5
```
3. Run test script
```sh
MLFLOW_TRACKING_URI=http://YOUR_HOST:5000 MLFLOW_TRACKING_USERNAME=HTPASSWD_USERNAME MLFLOW_TRACKING_PASSWORD=HTPASSWD_PASSWORD python test.py
```
4. Check MLflow UI on new experiment and model at 
```
http://YOUR_HOST:5000
```

### Description
Selected stores:
1. RDBMS [PostgreSQL](https://www.postgresql.org/) as `Backend store`
2. S3 compatible [MinIO](https://min.io/) as `Artifact store`

Containers used:
1. Local image for MLflow
2. [postgres](https://hub.docker.com/_/postgres) for PostgreSQL
3. [minio](https://hub.docker.com/r/minio/minio) for MinIO
4. [minio/mc](https://hub.docker.com/r/minio/mc/) for MinIO Client
5. [nginx](https://hub.docker.com/_/nginx) for MinIO Nginx
6. [nginx](https://hub.docker.com/_/nginx) for MLflow Nginx
7. Optional [pgadmin4](https://hub.docker.com/r/dpage/pgadmin4/) for pgAdmin 

See [docs](https://mlflow.org/docs/latest/tracking.html#scenario-5-mlflow-tracking-server-enabled-with-proxied-artifact-storage-access) for more information
