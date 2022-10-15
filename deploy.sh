docker build -t phuaweijie/multi-client:latest -t phuaweijie/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t phuaweijie/multi-server:latest -t phuaweijie/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t phuaweijie/multi-worker:latest -t phuaweijie/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push phuaweijie/multi-client:latest
docker push phuaweijie/multi-server:latest
docker push phuaweijie/multi-worker:latest

docker push phuaweijie/multi-client:$SHA
docker push phuaweijie/multi-server:$SHA
docker push phuaweijie/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=phuaweijie/multi-server:$SHA
kubectl set image deployments/client-deployment client=phuaweijie/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=phuaweijie/multi-worker:$SHA
