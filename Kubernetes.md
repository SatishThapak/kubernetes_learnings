# Kubernetes

Kubernetes is an open-source platform that automates the deployment, scaling, and management of containerized applications.

---

## 🔑 Key Concepts of Kubernetes

1. **Container Orchestration**  
   Manages containers (like those created by Docker) across multiple hosts, handling scheduling, scaling, and failover.

2. **Declarative Configuration**  
   You define the desired state of your system (e.g., number of replicas, resource limits), and Kubernetes maintains it.

3. **Self-Healing**  
   Automatically replaces failed containers, restarts crashed ones, and kills those that don’t respond to health checks.

4. **Load Balancing & Service Discovery**  
   Distributes traffic across containers and provides internal DNS for services.

5. **Rolling Updates & Rollbacks**  
   Deploy new versions of applications without downtime and revert if something goes wrong.

6. **Storage Orchestration**  
   Mounts local or cloud storage as needed by containers.

---

## 🛠️ Why Kubernetes Matters

- **Scalability**: Easily scale applications up or down based on demand.
- **Portability**: Works across public clouds, private clouds, and on-premises environments.
- **Efficiency**: Optimizes hardware usage and reduces infrastructure costs.
- **Community & Ecosystem**: Backed by a large community and supported by major cloud providers like AWS, Azure, and Google Cloud.

---

## 🏗️ Kubernetes cluster Architecture

![Kubernetes Cluster Components](./imagesKubernetes_cluster.png)

Kubernetes architecture follows a master-worker model, ensuring scalability, fault tolerance, and efficient orchestration.

### Control Plane (Master Node)

Manages the cluster and makes global decisions.

- **API Server**: Front-end for the control plane; handles REST operations.
- **Scheduler**: Assigns workloads (Pods) to nodes based on resource availability.
- **Controller Manager**: Maintains cluster state and performs background tasks.
- **etcd**: Distributed key-value store for configuration and state.
- **Cloud Controller Manager** *(optional)*: Integrates with cloud provider APIs.

### Worker Nodes

Run the containerized applications.

- **Kubelet**: Ensures containers are running in Pods as expected.
- **Kube-Proxy**: Manages network routing and load balancing.
- **Container Runtime**: Executes containers (e.g., Docker, containerd).

### Component Interaction

- The **API Server** is the central hub for communication.
- The **Scheduler** places Pods on suitable nodes.
- The **Controller Manager** ensures the desired state is maintained.
- **etcd** stores all cluster data.
- **Kubelet** and **Kube-Proxy** operate on each node to manage containers and networking.

### Cluster Composition

| Component              | Role                                      |
|------------------------|-------------------------------------------|
| API Server             | Cluster gateway and communication hub     |
| Scheduler              | Pod placement and resource allocation     |
| Controller Manager     | Maintains cluster state                   |
| etcd                   | Stores configuration and state            |
| Kubelet                | Manages containers on each node           |
| Kube-Proxy             | Handles networking and service routing    |
| Container Runtime      | Executes containers (e.g., Docker)        |

---

## 📚 Resources

- [Kubernetes Official Documentation](https://kubernetes.io/docs/)
- [Interactive Tutorials](https://kubernetes.io/docs/tutorials/)
- [GitHub Repository](https://github.com/kubernetes/kubernetes)

---

Feel free to fork this repo and contribute improvements or examples!
