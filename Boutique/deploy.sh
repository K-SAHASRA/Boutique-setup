kubectl apply -f boutique-v2.yaml
kubectl scale deployment/frontend --replicas=2
kubectl scale deployment/recommendationservice --replicas=2
