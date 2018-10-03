docker build -t raghavendranataraj/multi-client:latest -t raghavendranataraj/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t raghavendranataraj/multi-server:latest -t raghavendranataraj/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t raghavendranataraj/multi-worker:latest -t raghavendranataraj/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push raghavendranataraj/multi-client:latest
docker push raghavendranataraj/multi-server:latest
docker push raghavendranataraj/multi-worker:latest

docker push raghavendranataraj/multi-client:$SHA
docker push raghavendranataraj/multi-server:$SHA
docker push raghavendranataraj/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=raghavendranataraj/multi-server:$SHA
kubectl set image deployments/client-deployment client=raghavendranataraj/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=raghavendranataraj/multi-worker:$SHA
