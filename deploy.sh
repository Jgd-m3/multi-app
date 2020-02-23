docker build -t jgddocker/multi-client:latest -t jgddocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jgdocker/multi-server:latest -t jgddocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jgddocker/multi-worker:latest -t jgddocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jgddocker/multi-client:latest
docker push jgddocker/multi-server:latest
docker push jgddocker/multi-worker:latest

docker push jgddocker/multi-client:$SHA
docker push jgddocker/multi-server:$SHA
docker push jgddocker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=jgddocker/multi-client:$SHA
kubectl set image deployments/server-deployment server=jgddocker/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jgddocker/multi-worker:$SHA
