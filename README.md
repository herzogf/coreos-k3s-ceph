# K3S on CoreOS

Label the nodes:
```
sudo /usr/local/bin/k3s kubectl label node k3s-server-0.example.net kubernetes.io/role=master
sudo /usr/local/bin/k3s kubectl label node k3s-agent-0.example.net kubernetes.io/role=worker
sudo /usr/local/bin/k3s kubectl label node k3s-agent-1.example.net kubernetes.io/role=worker
sudo /usr/local/bin/k3s kubectl label node k3s-agent-0.example.net node-role.kubernetes.io/worker="true"
sudo /usr/local/bin/k3s kubectl label node k3s-agent-1.example.net node-role.kubernetes.io/worker="true"
```

## Traefik

Install the Cluster:
```
sudo /usr/local/bin/k3s kubectl create -f /opt/cluster/01-ceph-common.yaml
sudo /usr/local/bin/k3s kubectl create -f /opt/cluster/02-ceph-operator.yaml
sudo /usr/local/bin/k3s kubectl create -f /opt/cluster/03-ceph-cluster.yaml
sudo /usr/local/bin/k3s kubectl create -f /opt/cluster/04-ceph-filesystem.yaml
sudo /usr/local/bin/k3s kubectl create -f /opt/cluster/05-ceph-storageclass.yaml
sudo /usr/local/bin/k3s kubectl create -f /opt/cluster/06-traefik-common.yaml
sudo /usr/local/bin/k3s kubectl create -f /opt/cluster/07-traefik-deployment.yaml
sudo /usr/local/bin/k3s kubectl create -f /opt/cluster/08-ceph-dashboard-ingress.yaml
```

Get the password for the Ceph UI with:
```
sudo /usr/local/bin/k3s kubectl -n rook-ceph get secret rook-ceph-dashboard-password -o jsonpath="{['data']['password']}" | base64 --decode && echo
```
