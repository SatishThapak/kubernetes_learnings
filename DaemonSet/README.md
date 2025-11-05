## 🧩 DaemonSet in Kubernetes

### 🔍 What is a DaemonSet?
- A DaemonSet is a Kubernetes workload controller that ensures a specific pod runs on every node (or a subset of nodes) in a cluster.

- For example, in a cluster with 3 nodes, creating a DaemonSet will automatically deploy 3 pods—one per node. There's no need to manage replicas manually.

- When a new node is added to the cluster, the DaemonSet controller will automatically schedule a pod on that node.

### How it works
- The DaemonSet controller continuously monitors the cluster for node additions or deletions.

- It ensures that the desired pod is added to new nodes and removed from deleted nodes accordingly.

### 🛠️ Common Use Cases
DaemonSets are ideal for deploying system-level services across nodes, such as:
- Log collection agents (e.g., Fluentd, Filebeat)
- Network proxies (e.g., kube-proxy)
- CNI plugins (e.g., Weave Net, Canal)
- Node monitoring tools (e.g., Prometheus Node Exporter)

### Example of Daemonset:

![image](https://github.com/user-attachments/assets/71725083-89a7-4e93-a1ed-df4c8adc94c3)

- In the above screenshot, you can see 2 daemonsets are deployed in the kube-system namespace. i.e, Canal and Kube-proxy.
- Similarily, we can also create custom daemonset by following below steps.

### Steps to deploy daemonset:

- You will see 1 manifest in the same directory (DaemonSet) with name daemonset-deploy.yaml.
- Copy the content of the manifest and run the following command to deploy it.
```bash
kubectl apply -f daemonset-deploy.yaml
```
- After applying, you will see the daemonset pods are created and replicas are equal to the number of nodes including control-plane.

![image](https://github.com/user-attachments/assets/e07e794e-4557-4ad1-bb4b-dddc4001697c)
