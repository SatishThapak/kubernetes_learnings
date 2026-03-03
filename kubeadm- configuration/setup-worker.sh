#!/bin/bash

# Execute ONLY on Worker Nodes

# 1. Reset any existing Kubernetes state
echo "Resetting kubeadm state..."
sudo kubeadm reset -f
sleep 2

# 2. Remove old CNI configs (optional cleanup)
echo "Cleaning up old CNI configs..."
sudo rm -rf /etc/cni/net.d
sleep 2

# 3. Run the join command from the master node
# Replace <JOIN_COMMAND> with the actual command output from the master.
# Example:
# sudo kubeadm join <control-plane-ip>:6443 --token <token> \
# --discovery-token-ca-cert-hash sha256:<hash> \
# --cri-socket "unix:///run/containerd/containerd.sock" --v=5

echo "Joining the cluster..."
<JOIN_COMMAND>
sleep 2

# 4. Verify kubelet status
echo "Checking kubelet status..."
sudo systemctl status kubelet --no-pager
sleep 2

echo "Worker node successfully joined the cluster."
