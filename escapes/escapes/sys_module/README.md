# CAP_SYS_MODULE example privilage escalation.

kubectl apply -f pod.yaml

### Docker:
```sh
docker run --cap-add=SYS_MODULE -it ubuntu bash
```
kubectl exec -it cap-sys-module  -- /bin/bash

### K8s:

kubectl apply -f pod.yaml
kubectl exec -it cap-sys-module  -- /bin/bash

