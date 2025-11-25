# Kubernetes Ingress Controller with Minikube

In this walkthrough, we’ll configure an Ingress Controller to route traffic between two services—Apache (httpd) and NGINX—running inside a Minikube cluster.

### 🔧 Prerequisites for Local Ubuntu Setup

1. Ubuntu system (your local machine) with at least:
- 2 CPU cores
- 4 GB RAM
- Internet connectivity for pulling container images
2. Virtualization support enabled (check with egrep -q 'vmx|svm' /proc/cpuinfo && echo "Supported").
3. Docker or containerd installed (Minikube needs a container runtime).
4. kubectl installed to interact with the cluster.

Minikube installed and configured. 👉 Follow [this Minikube setup guide](<../Minikube Installation.md>).

---
### Verify Cluster Status

```bash
minikube status
kubectl get nodes
```
## Create Apache Deployment & Service
``` bash
# apache-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: apache-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: apache
  template:
    metadata:
      labels:
        app: apache
    spec:
      containers:
      - name: apache
        image: httpd:2.4
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: apache-service
spec:
  selector:
    app: apache
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: ClusterIP

```
---

Apply it:
``` bash
kubectl apply -f apache-deployment.yaml
```
### Create NGINX Deployment & Service

```bash
# nginx-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: ClusterIP

```
Apply it:

```bash
kubectl apply -f nginx-deployment.yaml
```

## Enable Ingress Controller
```bash
minikube addons enable ingress
```
---

## Create Ingress Resource

```bash
# ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: apache-nginx-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: "tws.com"
    http:
      paths:
      - path: /apache
        pathType: Prefix
        backend:
          service:
            name: apache-service
            port:
              number: 80
      - path: /nginx
        pathType: Prefix
        backend:
          service:
            name: nginx-service
            port:
              number: 80

```
Apply it:

```bash
kubectl apply -f ingress.yaml
```
## Configure Host Mapping

Map the Minikube IP to your custom domain (demo.com):

```bash
echo "$(minikube ip) tws.com" | sudo tee -a /etc/hosts
```
Or manually edit /etc/hosts and add:

```bash
<minikube-ip> demo.com
``` 

## Test Routing

Access Apache:

```bash
curl http://demo.com/apache
```
Access NGINX:

```bash
curl http://demo.com/nginx
```
## Optional: Port Forward Services

Apache: 

```bash 
kubectl port-forward svc/apache-service 8081:80 --address 0.0.0.0 & 
```
NGINX: 

``` bash 
kubectl port-forward svc/nginx-service 8082:80 --address 0.0.0.0 & 
```

