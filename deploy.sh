docker build -t deplake/multi-client:latest -t deplake/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t deplake/multi-server:latest -t deplake/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t deplake/multi-worker:latest -t deplake/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push deplake/multi-client:latest
docker push deplake/multi-server:latest
docker push deplake/multi-worker:latest

docker push deplake/multi-client:$SHA
docker push deplake/multi-server:$SHA
docker push deplake/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=deplake/multi-server:$SHA
kubectl set image deployments/client-deployment client=deplake/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=deplake/multi-worker:$SHA
