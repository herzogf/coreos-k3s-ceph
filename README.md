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

UniFi certificates were generated with:

```
datefudge --static '2020-01-01 01:00:00' \
openssl req -x509 \
    -newkey rsa:4096 \
    -keyout tls.key.pem -nodes \
    -out tls.crt.pem \
    -days 29220 \
    -subj '/CN=UniFi/O=ExampleNET' \
    -addext "subjectAltName = DNS:mongo-0.mongo.unifi.svc.example.net,DNS:mongo-1.mongo.unifi.svc.example.net,DNS:mongo-2.mongo.unifi.svc.example.net"
```

Install MongoDB for UniFi Controller:
```
sudo /usr/local/bin/k3s kubectl create -f /opt/unifi/01-unifi-common.yaml
sudo /usr/local/bin/k3s kubectl create -f /opt/unifi/02-unifi-mongo.yaml
```

Initialize the MongoDB replica set:

```
sudo /usr/local/bin/k3s kubectl -n unifi exec -it mongo-0 -- mongo -u admin -p ExampleNET
```

Paste the following:
```
rs.initiate({
  "_id":"unifi",
  "members":[
    { "_id":0, "host":"mongo-0.mongo.unifi.svc.example.net:27017" },
    { "_id":1, "host":"mongo-1.mongo.unifi.svc.example.net:27017" },
    { "_id":2, "host":"mongo-2.mongo.unifi.svc.example.net:27017" }
  ]
})
```

Install the UniFi Controller:
```
sudo /usr/local/bin/k3s kubectl create -f /opt/unifi/03-unifi-unifi.yaml
```

Install The Lounge:
```
sudo /usr/local/bin/k3s kubectl create -f /opt/thelounge/thelounge.yaml
```
