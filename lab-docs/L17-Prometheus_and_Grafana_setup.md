# Prometheus setup
-  Prometheus is an Open-source systems monitoring and alerting toolkit
   It helps us to monitor system and in case it sees anomality , it send alerts
-  Prometheus collects and stores the metrics as time series data.
   It collect metrics from sources and keep it in the server as time series data.
-  Prometheus Scrapes targets i.e Prometheus go by itsself to collect data frm targets
-  PromQl is the languages to query time series in Prometheus
   In the prometheus we store metrics and the metrics are query with promQL
-  Service Discovery helps find our services and monitor them
   Prometheus monitor some of the services, with the help of 'Service Discovery'
   Kubernetes is monitor by Kubernetes by Default because its part of the service
-  Exporters helps to monitor 3rd party components
   If prometheus don't discover 3rd party components, we need the help of 'Exporters'
   Exporters are agent for Prometheus i.e to monitor nginx, we need to exporter for nginx to be deploy
   By default service discovery is not available for nginx
-  Prometheus can send alerts to the Alert manager. 
   By default Prometheus come with Alert Manager. Its like a GUI that help us to find out what alerts are they. Instead of Alert Manager we use Grafana
   Alert Manager is in-built feature in Prometheus
-  Prometheus runs onport 9090 and Alert manager runs on 9093
### pre-requisites
1. Kubernetes cluster
2. helm

## Setup Prometheus

1. Create a dedicated namespace for prometheus
   ```sh
   kubectl create namespace monitoring
   ```

2. Add Prometheus helm chart repository
   ```sh
   helm repo add prometheus-grafana-community https://prometheus-community.github.io/helm-charts 
   helm pull prometheus-grafana-community/kube-prometheus-stack
   ```

3. Update the helm chart repository
   ```sh
   helm repo update
   helm repo list
   ```
   Before installation pull the helm charts and change the services below to load balancer type
   - prometheus-grafana
   - prometheus-kube-prometheus-prometheus

4. Install the prometheus

   ```sh
    helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring
   ```

5. Above helm create all services as ClusterIP. To access Prometheus out side of the cluster, we should change the service type load balancer
   ```sh 
   kubectl edit svc prometheus-kube-prometheus-prometheus -n monitoring
   change the service.yaml type to load balancer
   
   ```
6. Login to Prometheus dashboard to monitor application
copy the load balancer arn to the browser
   https://ELB:9090

7. Check for node_load15 executor to check cluster monitoring 

8. We check similar graphs in the Grafana dashboard itself. for that, we should change the service type of Grafana to LoadBalancer

   ```sh 
   kubectl edit svc prometheus-grafana
   ```

9.  To login to Grafana account, use the below username and password 
    ```sh
    username: admin
    password: prom-operator
    ```
10. Here we should check for "Node Exporter/USE method/Node" and "Node Exporter/USE method/Cluster"
    USE - Utilization, Saturation, Errors
   
11. Even we can check the behavior of each pod, node, and cluster 

                        Grafana
-  Grafana is a multi-platform open-source analytics and interractive visualization web application
-  It provided charts, graphs and alerts for the web when connected to supported data services
-  Grafana allows us to query, visualize, alert and understand our metrics, no matter where they are  stored. some supported data sources in addition to Prometheus are AWS Cloudwatch, AzureMonitor, PostgreSQL, Elasticsearch and many more.
-  we can creat our own dashboard or use the existing ones provided by Grafana. we can personalise the dashboard as per our requirements.
