# One

https://www.crowdstrike.com/blog/cve-2022-0185-kubernetes-container-escape-using-linux-kernel-exploit/

## Intro

The unshare syscall is a good example of capabilites escalation and its mitication with DAC Seccomp.

## Start Kind Server / Build / Deploy test app

- bash localReg.sh
- docker build . -t localhost:5001/getcaps:0.1
- docker push localhost:5001/getcaps:0.1
- kubectl apply -f pod.yaml
- kubectl logs protected

## Test coment and uncomment unshare syscall for adding CAP_SYS_ADMIN
```sh
capsh --print | grep --color=auto cap_sys_admin
```
