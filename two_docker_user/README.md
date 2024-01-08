# Docker User

## Intro

Many container breakouts are nullfied by running containers as unprivilenged users (NonRoot).

This can be as simple as generating a new user and specifying the USER command in the Dockerfile.

But with the unshare syscall this maynot be enough...

```
RUN adduser -D headeruser && chown headeruser /bin/headers
USER headeruser
```

Test:

- make build
- make push
- make deploy


## Test
```
bash-3.2$ kubectl exec -it header-headerschart-85958547b6-nbskw -- /bin/sh -c 'whoami'
headeruser
```

## It is still posible via the unshare syscall to escalate to root by default
```
bash-3.2$ kubectl exec -it header-headerschart-85958547b6-nbskw -- /bin/sh
/ $ whoami
headeruser
/ $ unshare -Urm
header-headerschart-85958547b6-nbskw:/# whoami
root
header-headerschart-85958547b6-nbskw:/#
```

## Solution seccompProfiles in security context

Uncomment out the securityContext in the helm charts values file and redeploy:

```
securityContext:
  #seccompProfile:
  #  type: RuntimeDefault

```
- make clean
- make deploy

```
bash-3.2$ kubectl exec -it header-headerschart-d9cbb4c7b-qtxhg -- /bin/sh
/ $ unshare -Urm
unshare: unshare(0x10020000): Operation not permitted
```

The container is now restricted to our headersuser user.
