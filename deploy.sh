docker build -t samvidocker/multi-client-k8s:latest -t samvidocker/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t samvidocker/multi-server-k8s:latest -t samvidocker/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t samvidocker/multi-worker-k8s:latest -t samvidocker/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push samvidocker/multi-client-k8s:latest
docker push samvidocker/multi-server-k8s:latest
docker push samvidocker/multi-worker-k8s:latest

docker push samvidocker/multi-client-k8s:$SHA
docker push samvidocker/multi-server-k8s:$SHA
docker push samvidocker/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=samvidocker/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=samvidocker/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=samvidocker/multi-worker-k8s:$SHA