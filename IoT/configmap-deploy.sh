kubectl create configmap nodered-flow --from-file=flows.json --namespace=iot-app
kubectl create configmap nodered-package --from-file=package.json --namespace=iot-app
kubectl create configmap mosquitto-conf --from-file=mosquitto.conf --namespace=iot-app
