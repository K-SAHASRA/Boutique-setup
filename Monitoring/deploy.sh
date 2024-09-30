kubectl create namespace monitoring
kubectl apply -f cadvisor.yaml # https://github.com/google/cadvisor/blob/master/deploy/kubernetes/base/daemonset.yaml
kubectl apply -f node-exporter.yaml
kubectl apply -f monitoring-service.yaml
