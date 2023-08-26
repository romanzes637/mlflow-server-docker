until (/usr/bin/mc config host add minio-mlflow http://nginx-minio-mlflow:9000 ${MINIO_ROOT_USER} ${MINIO_ROOT_PASSWORD}) do echo '...waiting...' && sleep 1; done
/usr/bin/mc mb minio-mlflow/${MINIO_MLFLOW_BUCKET_NAME};
/usr/bin/mc policy set public minio-mlflow/${MINIO_MLFLOW_BUCKET_NAME};
exit 0