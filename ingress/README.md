# Kubernetes Ingress Controller with Minikube

In this walkthrough, we’ll configure an Ingress Controller to route traffic between two services—Apache (httpd) and NGINX—running inside a Minikube cluster.
---

### 🔧 Prerequisites for Local Ubuntu Setup

1. Ubuntu system (your local machine) with at least:

- 2 CPU cores
- 4 GB RAM
- Internet connectivity for pulling container images
2. Virtualization support enabled (check with egrep -q 'vmx|svm' /proc/cpuinfo && echo "Supported").
3. Docker or containerd installed (Minikube needs a container runtime).
4. kubectl installed to interact with the cluster.

Minikube installed and configured. 👉 Follow [this Minikube setup guide](<../Minikube Installation.md>).