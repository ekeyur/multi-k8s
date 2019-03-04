docker build -t ekeyur/multi-client:latest -t ekeyur/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ekeyur/multi-server:latest -t ekeyur/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ekeyur/multi-worker:latest -t ekeyur/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ekeyur/multi-client:latest
docker push ekeyur/multi-server:latest
docker push ekeyur/multi-worker:latest

docker push ekeyur/multi-client:$SHA
docker push ekeyur/multi-server:$SHA
docker push ekeyur/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=ekeyur/multi-server:$SHA
kubectl set image deployments/client-deployment client=ekeyur/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ekeyur/multi-worker:$SHA