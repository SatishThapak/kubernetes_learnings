# Kubernetes Cluster Setup Toolkit

This repository contains scripts to automate the setup of a Kubernetes cluster using **containerd** as the runtime and **Calico** as the CNI plugin.  
It includes scripts for **all nodes (master + workers)**, **master node initialization**, and **worker node joining**.

---

## 📋 Prerequisites

- Ubuntu (20.04/22.04 recommended)
- Root or sudo privileges
- Internet access for package installation
- Swap disabled (handled in the script)
- Ensure required Kubernetes ports are open:
  - `6443` (API server)
  - `10250` (kubelet API)
  - `10251` (scheduler)
  - `10252` (controller-manager)

---

## 🗂 Scripts Overview

### 1. `setup-all-nodes.sh`
Run this on **all nodes (master + workers)** to prepare the environment.

- Disables swap
- Loads kernel modules (`overlay`, `br_netfilter`)
- Configures sysctl for networking
- Installs **containerd** and configures it with systemd cgroups
- Installs Kubernetes components (`kubelet`, `kubeadm`, `kubectl`)
- Holds versions to prevent accidental upgrades

---

### 2. `setup-master.sh`
Run this **only on the master node**.

- Initializes the Kubernetes control plane (`kubeadm init`)
- Configures local `kubectl` access
- Installs **Calico** network plugin
- Generates the **join command** for worker nodes

> ⚠️ Use `--pod-network-cidr=192.168.0.0/16` with `kubeadm init` to match Calico defaults.

---

### 3. `setup-worker.sh`
Run this **only on worker nodes**.

- Resets any previous kubeadm state
- Cleans up old CNI configs
- Executes the join command provided by the master node  
  (with `--cri-socket "unix:///run/containerd/containerd.sock" --v=5`)

---

## 🚀 Step-by-Step Usage

### 1. Prepare All Nodes
```bash
./setup-all-nodes.sh
```
### 1. Initialize Master Node
```
./setup-master.sh
```
- Copy the join command output.

### 3. Join Worker Nodes
- Edit setup-worker.sh and paste the join command where indicated.
- Run on each worker:
```
./setup-worker.sh
```
### Verification
On the master node, check cluster status:
```
kubectl get nodes
kubectl get pods -n kube-system
```
---------

[nodes](../images/kubernetes.png)


### Optional Enhancements
### Enable kubectl autocompletion:
```
echo "source <(kubectl completion bash)" >> ~/.bashrc
```
### Save join command automatically:
```
kubeadm token create --print-join-command > ~/join-worker.sh
chmod +x ~/join-worker.sh
```
### Deploy a test workload:
```
kubectl create deployment nginx --image=nginx
kubectl expose deployment nginx --port=80 --type=NodePort
```

