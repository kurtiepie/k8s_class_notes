# Linux Capabilities with Containers and Kubernetes 2

## Intro

 A Pods container can be configure in a PodSpecs seurity context.
 ```sh
 securityContext:
    capabilities:
      drop:
        - all
      add: ["CAP_SYS_ADMIN"]
 ```
PodSpec:
## Kubernetes Example
```sh
apiVersion: v1
kind: Pod
metadata:
  name: localping
  labels:
    app: localping
spec:
  containers:
  - name: localping
    image: alpine:latest
    command: [ "/bin/sh", "-c", "--" ]
    args: [ "ping -c2 -w2 127.0.0.1" ]
```
test
```sh
$ kubectly apply -f localping.yaml
$ kubectl logs localping
PING 127.0.0.1 (127.0.0.1): 56 data bytes
64 bytes from 127.0.0.1: icmp_seq=0 ttl=64 time=0.050 ms
64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.051 ms
--- 127.0.0.1 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max/stddev = 0.050/0.051/0.051/0.000 ms
```

Drop capabilities and Test Again
```sh
apiVersion: v1
kind: Pod
metadata:
  name: localping
  labels:
    app: localping
spec:
  containers:
  - name: localping
    image: alpine:latest
    securityContext:
      capabilities:
        drop:
          - all
    command: [ "/bin/sh", "-c", "--" ]
    args: [ "ping -c2 -w2 127.0.0.1" ]
```
Test
```sh
bash-3.2$ kubectl logs localping                            
ping: permission denied (are you root?)
PING 127.0.0.1 (127.0.0.1): 56 data bytes
```
Add back nessessary capability only
```sh
kind: Pod
metadata:
  name: localping
  labels:
    app: localping
spec:
  containers:
  - name: localping
    image: alpine:latest
    securityContext:
      capabilities:
        drop:
          - all
        add:
          - NET_RAW
    command: [ "/bin/sh", "-c", "--" ]
    args: [ "ping -c2 -w2 127.0.0.1" ]
```
Test:
```sh
bash-3.2$ kubectl apply -f t.yaml 
pod/localping created
bash-3.2$ kubectl logs localping                            
PING 127.0.0.1 (127.0.0.1): 56 data bytes
64 bytes from 127.0.0.1: seq=0 ttl=64 time=0.088 ms
```
