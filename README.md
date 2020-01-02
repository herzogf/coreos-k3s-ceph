### K3S on CoreOS

Label the nodes:
```
sudo /usr/local/bin/k3s kubectl label node k3s-server-0.example.net kubernetes.io/role=master
sudo /usr/local/bin/k3s kubectl label node k3s-agent-0.example.net kubernetes.io/role=worker
sudo /usr/local/bin/k3s kubectl label node k3s-agent-1.example.net kubernetes.io/role=worker
sudo /usr/local/bin/k3s kubectl label node k3s-agent-0.example.net node-role.kubernetes.io/worker="true"
sudo /usr/local/bin/k3s kubectl label node k3s-agent-1.example.net node-role.kubernetes.io/worker="true"
```

Install the Operator:
```
sudo /usr/local/bin/k3s kubectl create -f /opt/rook/ceph-01-common.yaml
sudo /usr/local/bin/k3s kubectl create -f /opt/rook/ceph-02-operator.yaml
```
Wait until all Operator related pods are running then install the Cluster:
```
sudo /usr/local/bin/k3s kubectl create -f /opt/rook/ceph-03-cluster.yaml
```
Wait until all Cluster related pods are running then install the Ingress for the dashboard:
```
sudo /usr/local/bin/k3s kubectl create -f /opt/rook/ceph-04-dashboard-ingress.yaml
```

Get the password for the UI with:
```
sudo /usr/local/bin/k3s kubectl -n rook-ceph get secret rook-ceph-dashboard-password -o jsonpath="{['data']['password']}" | base64 --decode && echo
```
