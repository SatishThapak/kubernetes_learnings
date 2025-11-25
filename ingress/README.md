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
