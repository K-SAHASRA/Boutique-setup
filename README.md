# Boutique, IoT, Acme-Air, Monitoring for Amazon Elastic Kubernetes Cluster (EKS)  

## Install Kubectl and AWS CLI
Run this script to install Kubectl and AWS CLI
> amazon-kubectl-install.sh

Login to your Amazon AWS CLI with your AWS Access Key and Secret Key. Make sure to edit the script to add the name of your Amazon EKS Cluster in the *update-kubeconfig --name* 
> aws-cli-log-in.sh

Check if your kubectl is connected to your Cluster
> kubectl get nodes

## Deploy Boutique
Once your Kubernetes EKS Cluster and Kubectl is set up, go into the ./Boutique folder

> cd ./Boutique

Make sure to edit the boutique-v2.yaml file. Remove the NodeName for each of the Deployements in the Yaml file.
> Example: nodeName: ip-172-30-0-144.ec2.internal

This was done in our experiments to replicate the same Pod Deployment when we redeploy the EKS Cluster, so all our experiments remain constant. 
You can either remove them and allow Kubernetes to perform the scheduling, or replace the nodeName with the names of your EKS Nodes.

To deploy Boutique, run the script:
> ./deploy.sh

## Deploy Monitoring
1. To deploy Monitoring (cAdvisor and NodeExporter), run the deploy.sh in the /Monitoring folder.

   > cd ./Monitoring
   
   >./deploy.sh
   
3. To Monitor Locust (The Workload Generator for Boutique), make sure to change the value of LOCUST_EXPORTER_URI to the pod IP Address of the Load Generator of Boutique in locust-exporter.yaml file
```
      env:
      - name: LOCUST_EXPORTER_URI
        value: 'http://172.30.0.235:8089'
```
3. Then run:
   > kubectl apply -f locust-exporter.yaml

4. Connect the cAdvisor, NodeExporter and LocustExporter to Prometheus and Grafana.
   
5. To remove the Monitoring, run the script and following command in the cli:
   >  kubectl delete -f locust-exporter.yaml
   
   >  ./delete-all.sh
   
